#include "flickrmanager.h"
#include "flickritem.h"

#include <QList>
#include <QDesktopServices>
#include <QMessageBox>
#include <QSettings>
#include <QHash>
#include <QStringListModel>
#include <QMapIterator>

class FlickrManagerPrivate{
public:
    FlickrManagerPrivate():
            m_qtFlickr(0),
            m_requestId(),
            m_settings("QtFlickrWidget","Authorization"),
            m_model()
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

};

FlickrManager::FlickrManager():
        d_ptr( new FlickrManagerPrivate )
{
    Q_D(FlickrManager);
    d->m_qtFlickr = new QtFlickr ( "5ed969460703ab6ae4f0ecbf4178be5d",
                                   "ee829960cd89d099", this );

    connect(d->m_qtFlickr,SIGNAL(requestFinished ( int, QtfResponse, QtfError, void* )),
            this,SLOT(requestFinished ( int, QtfResponse, QtfError, void* )));

    QString token = d->settingsValue("token");
    if(!token.isEmpty()){
        d->m_qtFlickr->setToken(token);
        getLatestContactUploads();
    }else{
        authenticate();
    }
}


FlickrManager:: ~ FlickrManager()
{
    delete d_ptr;
    d_ptr = 0;
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
    method.args.insert("count", "50" );
    method.args.insert("include_self", "1");
    method.args.insert("extras", "url_s,date_taken" );

    // Define in request section which fields are include the the response
    QtfRequest request ( "photo","url_s,username,title,datetaken,height_s,width_s" );
    d->m_requestId.insert(d->m_qtFlickr->get( method,request ), GetContactsPublicPhotos);

}

void FlickrManager::getPhotosOfContact(const QString & userId)
{
    QtfMethod method("flickr.people.getPhotosOf");
    method.args.insert("user_id", userId);
    method.args.insert("extras", "description,license,date_upload,date_taken,owner_name,original_format,last_update,geo,tags,views,url_s" );

    // Define in request section which fields are include the the response
    QtfRequest request ( "photo","description,license,date_upload,date_taken,owner_name,original_format,last_update,geo,tags,views,url_s" );
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->get( method,request ), GetPhotosOfContact);
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
                FlickrItem * item = new FlickrItem(this);
                item->setTitle( tag.attrs.value("title") );
                item->setUserName( tag.attrs.value("username") );
                item->setUrl(QUrl( tag.attrs.value("url_s")));
                item->setDateTaken( tag.attrs.value("datetaken"));
                item->setThumbWidth( tag.attrs.value("width_s").toInt());
                item->setThumbHeight( tag.attrs.value("height_s").toInt());
                d->m_model << item;

            }


            // Notify the world that model contains something now.
            emit modelUpdated();
        }break;
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

