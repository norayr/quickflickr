#include "flickrmanager.h"


#include <QList>
#include <QDesktopServices>
#include <QMessageBox>
#include <QSettings>
#include <QHash>
#include <QStringListModel>
#include <QMapIterator>
#include <QVariant>


class FlickrManagerPrivate{
public:
    FlickrManagerPrivate():
            m_qtFlickr(0),
            m_requestId(),
            m_settings("QuickFlickr","Authorization"),
            m_frob()
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
    QSettings        m_settings;
    QString m_frob;

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
    connect(d->m_qtFlickr,SIGNAL(requestFinished(int,QString,QtfError,void*)),
            this,SLOT(requestFinished(int,QString,QtfError,void*)));
    
    
    QString token = d->settingsValue("token");
    if(!token.isEmpty()){
        d->m_qtFlickr->setToken(token);        
        //getLatestContactUploads();
        emit proceed();
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
    method.args.insert("count", "30" );
    method.args.insert("include_self", "1");
    method.args.insert("single_photo", "true");
    method.args.insert("extras", "url_s,url_w,date_taken" );

    // Define in request section which fields are include the the response
    QtfRequest request ( "photo","url_s,username,owner,title,datetaken,height_s,width_s" );
    d->m_requestId.insert(d->m_qtFlickr->post( method, request,0,false ), GetContactsPublicPhotos);
    qDebug() << "Request for uploads send";

}

void FlickrManager::getPhotosOfContact(const QString & userId)
{
    // Clear the old stuff    
    Q_D(FlickrManager);    
    
    qDebug() << "getPhotosOfContact() Method";
    QtfMethod method("flickr.people.getPublicPhotos");
    method.args.insert("api_key", "ee829960cd89d099");
    method.args.insert("user_id", userId);
    method.args.insert("extras", "description,date_taken,username,original_format,last_update,geo,tags,o_dims,views,url_m" );
    method.args.insert("per_page","30");    
    QtfRequest request;
    request.requests.insert("photo","title,url_m,original_format,geo,tags,views,username,owner,id,farm,server");
    request.requests.insert("description",QString(""));    
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetPhotosOfContact);
}


void FlickrManager::getRecentActivity()
{
    Q_D(FlickrManager);
    QtfMethod method("flickr.activity.userPhotos");    
    method.args.insert("api_key", "ee829960cd89d099");    
    method.args.insert("timeframe","30d");
    method.args.insert("per_page","30");    
    QtfRequest request;
    request.requests.insert("item","type,id,owner,ownername,comments,secret,server,farm,views,faves,activity/event");
    request.requests.insert("title","");
    request.requests.insert("activity","");    
    request.requests.insert("event","type,username");    
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetRecentActivity);
}


void FlickrManager::getToken()
{
    Q_D(FlickrManager);
    QtfMethod method;
    method.method = "flickr.auth.getToken";
    method.args.insert( "frob", d->m_frob );
    QtfRequest request;
    request.requests.insert("token","");
    request.requests.insert("user","username,fullname,nsid");
    d->m_requestId.insert( d->m_qtFlickr->get(method, request), GetToken );   
}

void FlickrManager::getComments(const QString & photoId)
{
    QtfMethod method("flickr.photos.comments.getList");    
    method.args.insert("api_key", "ee829960cd89d099");    
    method.args.insert("photo_id", photoId);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetComments);
}
    
void FlickrManager::addComment(const QString & photoId, const QString & commentText )
{
    QtfMethod method("flickr.photos.comments.addComment");    
    method.args.insert("api_key", "ee829960cd89d099");    
    method.args.insert("photo_id", photoId);
    method.args.insert("comment_text", commentText);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), AddComment);
}

void FlickrManager::addFavorite( const QString & photoId )
{
    QtfMethod method("flickr.favorites.add");    
    method.args.insert("api_key", "ee829960cd89d099");    
    method.args.insert("photo_id", photoId);    
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), AddFavorite); 
}


void FlickrManager::getFavorites()
{
    QtfMethod method("flickr.favorites.getList");    
    method.args.insert("api_key", "ee829960cd89d099");        
    method.args.insert("extras","url_m,owner_name");
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetFavorites); 
}

void FlickrManager::removeFavorite( const QString & photoId )
{
    QtfMethod method("flickr.favorites.remove");    
    method.args.insert("api_key", "ee829960cd89d099");        
    method.args.insert("photo_id",photoId);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), RemoveFavorite); 
}

void FlickrManager::requestFinished ( int reqId, QtfResponse data, QtfError err, void* userData )
{
    Q_UNUSED( userData );
    Q_D(FlickrManager);

    switch( d->m_requestId.value(reqId)){
    case GetFrob:
        {
            Q_D(FlickrManager);
            d->m_frob = data.tags.value("frob").value;
            QUrl authUrl = d->m_qtFlickr->authorizationUrl(d->m_frob);
            emit authenticationRequired(authUrl);
                       
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
    
    default:
        {
            if ( !err.code){
                qWarning()<<"Error: "<<err.message;
            }
        }
        break;
    }
}


void FlickrManager::requestFinished ( int reqId, QString xmlData, QtfError err, void* userData )
{
    Q_UNUSED(userData);    
    Q_D(FlickrManager);
    switch( d->m_requestId.value(reqId)){
    case GetContactsPublicPhotos:        
        qDebug() << xmlData;
        emit contactsUploadsUpdated(xmlData);                                
        break;

    case GetPhotosOfContact:
        qDebug() << xmlData;
        emit photostreamUpdated(xmlData);
        break;        
        
    case GetRecentActivity:        
        qDebug() << xmlData;
        emit recentActivityUpdated(xmlData);
        break;
        
    case GetComments:
        qDebug() << xmlData;
        emit commentsUpdated(xmlData);
        break;
        
    case AddComment:
        Q_UNUSED(xmlData);
        emit commentAdded();
        break;
        
    case AddFavorite:
        Q_UNUSED(xmlData);
        // No specific response
        break;
        
    case GetFavorites:
        qDebug() << xmlData;
        emit favoritesUpdated(xmlData);
        break;
    
    case RemoveFavorite:
        emit favoriteRemoved();
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



bool FlickrManager::isAuthenticated() const
{
    Q_D(const FlickrManager);
    QString token = d->settingsValue("token");
    return !token.isEmpty();
}












