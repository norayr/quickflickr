#include "flickrmanager.h"
#include "flickritem.h"

#include <QList>
#include <QDesktopServices>
#include <QMessageBox>
#include <QSettings>
#include <QHash>
#include <QStringListModel>
#include <QMapIterator>
#include <QtConcurrentRun>


class FlickrManagerPrivate{
public:
    FlickrManagerPrivate():
            m_qtFlickr(0),
            m_requestId(),
            m_settings("QtFlickrWidget","Authorization"),
            m_model(),
            m_photoStreamModel()
    {
    }

    QSettings & settings(){
        return m_settings;
    }

    QString settingsValue(QString const & key) const{
        return m_settings.value(key).toString();
    }

    void setSettingsValue(QString const & key, QString const & value){
        m_settings.setValue(key, value);
    }

    QtFlickr * m_qtFlickr;
    QHash<int, FlickrManager::RequestId> m_requestId;    
    QSettings            m_settings;
    QList <QObject*> m_model;
    QList <QObject*> m_photoStreamModel;

};

FlickrManager::FlickrManager():
        d_ptr( new FlickrManagerPrivate )
{
    setObjectName("FlickrManager");        
}


FlickrManager:: ~ FlickrManager()
{
    delete d_ptr;
    d_ptr = 0;
}


void FlickrManager::activate()
{
    Q_D(FlickrManager);
    d->m_qtFlickr = new QtFlickr ( "5ed969460703ab6ae4f0ecbf4178be5d",
                                   "ee829960cd89d099", this );

    connect(d->m_qtFlickr,SIGNAL(requestFinished ( int, QtfResponse, QtfError, void* )),
            this,SLOT(requestFinished ( int, QtfResponse, QtfError, void* )));

    QString token = d->settingsValue("token");
    if(!token.isEmpty()){
        d->m_qtFlickr->setToken(token);        
        //getLatestContactUploads();
    }else{
        authenticate();
    }
}

void FlickrManager::authenticate()
{    
    QtfMethod method;
    method.method = "flickr.auth.getFrob";
    QtfRequest request;
    request.requests.insert("frob","");
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->get(method,request), GetFrob);
}


void FlickrManager::getLatestContactUploads()
{
    Q_D(FlickrManager);    
    QtfMethod method("flickr.photos.getContactsPublicPhotos");
    method.args.insert("user_id", d->settingsValue("nsid"));
    method.args.insert("count", "100" );
    method.args.insert("include_self", "1");
    method.args.insert("single_photo", "true");
    method.args.insert("extras", "url_s,url_w,date_taken" );

    // Define in request section which fields are include the the response
    QtfRequest request ( "photo","url_s,username,owner,title,datetaken,height_s,width_s" );
    d->m_requestId.insert(d->m_qtFlickr->post( method, request ), GetContactsPublicPhotos);
    qDebug() << "Request for uploads send";

}

void FlickrManager::getPhotosOfContact(const QString & userId)
{
    // Clear the old stuff    
    Q_D(FlickrManager);    

    qDeleteAll(d->m_photoStreamModel);
    d->m_photoStreamModel.clear();
    d->m_photoStreamModel << new FlickrItem(0);    
    emit photoStreamModelUpdated(d->m_photoStreamModel);

    qDebug() << "getPhotosOfContact() Method";
    QtfMethod method("flickr.people.getPublicPhotos");
    method.args.insert("api_key", "ee829960cd89d099");
    method.args.insert("user_id", userId);
    method.args.insert("extras", "description,date_taken,username,original_format,last_update,geo,tags,o_dims,views,url_m" );
    method.args.insert("per_page","100");    
    QtfRequest request;
    request.requests.insert("photo","title,url_m,original_format,geo,tags,views,username,owner,id,farm,server");
    request.requests.insert("description",QString(""));    
    d->m_requestId.insert(d->m_qtFlickr->post( method,request ), GetPhotosOfContact);
}


void FlickrManager::getRecentActivity()
{
    Q_D(FlickrManager);
    QtfMethod method("flickr.activity.userComments");
    method.args.insert("api_key", "ee829960cd89d099");    
    method.args.insert("time_frame","2d");
    method.args.insert("per_page","50");    
    QtfRequest request;
    request.requests.insert("item","type,id,owner,ownername,comments,secret,server,farm,views,faves");
    //request.requests.insert("title",QString(""));    
    request.requests.insert("event","type,username");
    d->m_requestId.insert(d->m_qtFlickr->post( method,request ), GetRecentActivity);
}

void FlickrManager::requestFinished ( int reqId, QtfResponse data, QtfError err, void* userData )
{
    Q_UNUSED( userData );
    Q_D(FlickrManager);

    switch( d->m_requestId.value(reqId)){
    case GetFrob:
        {
            QString frob = data.tags.value("frob").value;
            QUrl authUrl = d->m_qtFlickr->authorizationUrl(frob);
            // TODO MAke here something nice like make app to show QML
            // Web view
            QDesktopServices::openUrl ( authUrl );
            QMessageBox msgBox;
            msgBox.setText("Press Ok button when you have completed authorization through web browser");
            int result = msgBox.exec();
            if( result == QMessageBox::Ok){
                QtfMethod method;
                method.method = "flickr.auth.getToken";
                method.args.insert( "frob", frob );
                QtfRequest request;
                request.requests.insert("token","");
                request.requests.insert("user","username,fullname,nsid");
                d->m_requestId.insert( d->m_qtFlickr->get(method, request), GetToken );
            }

        }break;

    case GetToken:
        {

            QString token    = data.tags.value("token").value;
            QString username = data.tags.value("user").attrs.value("username");
            QString fullname = data.tags.value("user").attrs.value("fullname");
            QString nsid     = data.tags.value("user").attrs.value("nsid");
            d->m_qtFlickr->setToken(token);
            d->setSettingsValue("username",username);
            d->setSettingsValue("token",token);
            d->setSettingsValue("nsid",nsid);
            
            // Now we are authenticated, let's get some stuff from Flickr
            getLatestContactUploads();
        }
        break;
    case GetContactsPublicPhotos:
        {
            
            // Make sure that we delete the existing items first
            Q_D(FlickrManager);
            qDeleteAll(d->m_model);
            d->m_model.clear();
            
            // Go through each tag and create an item for model.
            // Add items backward to the model. I didn't figure out
            // how to make ListView to sort items in a model.r
            QMapIterator<QString, QtfTag> iterator(data.tags);
            iterator.toBack();
            while (iterator.hasPrevious()){
                iterator.previous();                
                QtfTag tag = iterator.value();                
                FlickrItem * item = new FlickrItem(0);
                item->setTitle( tag.attrs.value("title") );
                item->setUserName( tag.attrs.value("username") );
                item->setUrl(QUrl( tag.attrs.value("url_s")));
                item->setDateTaken( tag.attrs.value("datetaken"));
                item->setThumbWidth( tag.attrs.value("width_s").toInt());
                item->setThumbHeight( tag.attrs.value("height_s").toInt());
                item->setOwner( tag.attrs.value("owner"));
                item->setId( tag.attrs.value("id"));
                item->setServer( tag.attrs.value("server"));
                item->setFarm(tag.attrs.value("farm"));
                item->setOwner( tag.attrs.value("owner"));
                
                d->m_model << item;              
            }
            
            
            // Notify the world that model contains something now.
            emit modelUpdated(d->m_model);
        }break;

    case GetPhotosOfContact:
        {
        
        qDeleteAll(d->m_photoStreamModel);
        d->m_photoStreamModel.clear();        
        QList<QtfTag> tagList = data.tags.values("photo");
        QList<QtfTag> descList = data.tags.values("description");
        
        int i=tagList.size()-1;
        for ( ; i > 0; i--){                                    
            QtfTag tag = tagList.at(i);
            FlickrItem * item = new FlickrItem(0);
            item->setTitle( tag.attrs.value("title") );
            item->setUserName( tag.attrs.value("username") );
            item->setUrl(QUrl( tag.attrs.value("url_m")));
            item->setDateTaken( tag.attrs.value("datetaken"));
            item->setThumbWidth( tag.attrs.value("width_m").toInt());
            item->setThumbHeight( tag.attrs.value("height_m").toInt());
            item->setDescription( descList.at(i).value);
            item->setTags( tag.attrs.value("tags"));
            item->setViews( tag.attrs.value("views").toInt());
            item->setId( tag.attrs.value("id"));
            item->setServer( tag.attrs.value("server"));
            item->setFarm(tag.attrs.value("farm"));
            item->setOwner( tag.attrs.value("owner"));
            d->m_photoStreamModel << item;            
            
        }
        emit photoStreamModelUpdated(d->m_photoStreamModel);
            
        }break;
        
    case GetRecentActivity:
        {
            qDebug() << "GetRecentActivity";
            QList<QtfTag> tagList = data.tags.values("item");
            QList<QtfTag> descList = data.tags.values("event");
            
            for( int i=0; i < tagList.size(); i++){
                QtfTag tag = tagList.at(i);
                qDebug() << tag.attrs.value("type") << "Views: " << tag.attrs.value("views") 
                        << "Faves:" << tag.attrs.value("faves") << "Comments: " << tag.attrs.value("comments") 
                        << "Owner:" << tag.attrs.value("ownername");
                int commentCount = tag.attrs.value("comments").toInt();
                if ( commentCount > 0){
                    //qDebug() << "Comment:" << descList.at(i).value;    
                }
                
            }
        
        }
        break;
    default:
        {
            if ( !err.code){
                qWarning()<<"Error: "<<err.message;
            }
        }
        break;
    }
}

QList<QObject*> FlickrManager::model() const
{
    Q_D(const FlickrManager);
    return d->m_model;
}

QList<QObject*> FlickrManager::photoStreamModel() const
{
    Q_D(const FlickrManager);
    return d->m_photoStreamModel;
}


bool FlickrManager::isAuthenticated() const
{
    Q_D(const FlickrManager);
    QString token = d->settingsValue("token");
    return !token.isEmpty();
}












