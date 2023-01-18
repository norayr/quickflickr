/**
 * QuickFlickr - FlickrClient for mobile devices.
 *
 * Author: Marko Mattila (marko.mattila@d-pointer.com)
 *         http://www.d-pointer.com
 *
 *  QuickFlickr is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuickFlickr is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with QuickFLickr.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "flickrmanager.h"


#include <QList>
#include <QDesktopServices>
#include <QMessageBox>
#include <QSettings>
#include <QHash>
#include <QStringListModel>
#include <QMapIterator>
#include <QVariant>

#define KEY "cfa0d40dee57a1808c8c3c9b30f56ded"
#define SECRET "72c539e938abdfc0"

class FlickrManagerPrivate{
public:
    FlickrManagerPrivate():
            m_qtFlickr(0),
            m_requestId(),
            m_settings("d-pointer","quickflickr"),
            m_frob()
    {            
    }

    QSettings & settings()
    {
        return m_settings;
    }

    QString settingsValue(QString const & key) const
    {
        return m_settings.value(key).toString();
    }

    void setSettingsValue(QString const & key, QString const & value)
    {
        m_settings.setValue(key, value);
    }

    void removeKey(QString const & key)
    {
        m_settings.remove(key);
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
    d->m_qtFlickr = new QtFlickr ( KEY, SECRET, this );

    connect(d->m_qtFlickr,SIGNAL(requestFinished ( int, QtfResponse, QtfError, void* )),
            this,SLOT(requestFinished ( int, QtfResponse, QtfError, void* )));
    connect(d->m_qtFlickr,SIGNAL(requestFinished(int,QString,QtfError,void*)),
            this,SLOT(requestFinished(int,QString,QtfError,void*)));
    
    
    QString token = d->settingsValue("token");
    if(!token.isEmpty()){
        d->m_qtFlickr->setToken(token);                
        emit proceed();        
    }else{
        authenticate();        
    }
    
}

void FlickrManager::removeAuthentication()
{
    Q_D(FlickrManager);
    d->removeKey("token");
    authenticate();
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

void FlickrManager::getContacts()
{
    Q_D(FlickrManager);
    QtfMethod method("flickr.contacts.getList");
    method.args.insert("user_id", d->settingsValue("nsid"));
    QtfRequest request;
    d->m_requestId.insert(d->m_qtFlickr->post( method, request,0,false ), GetContacts);
}


void FlickrManager::getLatestContactUploads()
{
    Q_D(FlickrManager);    
    QtfMethod method("flickr.photos.getContactsPublicPhotos");
    method.args.insert("user_id", d->settingsValue("nsid"));
    method.args.insert("count", "20" );
    method.args.insert("include_self", "1");
    method.args.insert("single_photo", "true");
    //method.args.insert("extras", "date_taken" );
    QtfRequest request;
    d->m_requestId.insert(d->m_qtFlickr->post( method, request,0,false ), GetContactsPublicPhotos);    

}

void FlickrManager::getPhotostream(const QString & userId, int page)
{
    // Clear the old stuff    
    Q_D(FlickrManager);    
        
    qDebug() << "getPhotosOfContact() Method" << userId << page;
    QtfMethod method("flickr.people.getPublicPhotos");    
    method.args.insert("user_id", userId);    
    method.args.insert("extras", "owner_name,url_m,url_s" );
    method.args.insert("per_page","20");
    method.args.insert("page", QString::number(page));
    QtfRequest request;
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetPhotosOfContact);
}

void FlickrManager::getUserInfo( const QString & userId )
{
    Q_D(FlickrManager);
    QtfMethod method("flickr.people.getInfo");    
    method.args.insert("user_id", userId);
    QtfRequest request;
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetUserInfo);
}

void FlickrManager::getRecentActivity()
{
    Q_D(FlickrManager);
    QtfMethod method("flickr.activity.userPhotos");        
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
    method.args.insert("photo_id", photoId);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetComments);
}
    
void FlickrManager::addComment(const QString & photoId, const QString & commentText )
{    
    QtfMethod method("flickr.photos.comments.addComment");        
    method.args.insert("photo_id", photoId);
    method.args.insert("comment_text", commentText);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), AddComment);
}

void FlickrManager::addFavorite( const QString & photoId )
{
    QtfMethod method("flickr.favorites.add");          
    method.args.insert("photo_id", photoId);    
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), AddFavorite); 
}


void FlickrManager::getFavorites(int perPage, int page)
{
    QtfMethod method("flickr.favorites.getList");             
    method.args.insert("extras","url_s,owner_name");
    method.args.insert("per_page", QString::number(perPage));
    method.args.insert("page", QString::number(page));
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetFavorites); 
}

void FlickrManager::removeFavorite( const QString & photoId )
{
    QtfMethod method("flickr.favorites.remove");         
    method.args.insert("photo_id",photoId);
    QtfRequest request;    
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), RemoveFavorite); 
}


void FlickrManager::getPhotoInfo(const QString & photoId )
{
    QtfMethod method("flickr.photos.getInfo");    
    method.args.insert("photo_id", photoId);
    QtfRequest request;
    Q_D(FlickrManager);
    d->m_requestId.insert(d->m_qtFlickr->post( method,request,0,false ), GetPhotoInfo);
}

QString FlickrManager::nsid() const
{
    Q_D(const FlickrManager);
    return d->settingsValue("nsid");
}

QString FlickrManager::userName() const
{
    Q_D(const FlickrManager);
    return d->settingsValue("username");
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
        //qDebug() << xmlData;
        emit contactsUploadsUpdated(xmlData);                                
        break;

    case GetContacts:
        //qDebug() << xmlData;
        emit contactsUpdated(xmlData);
        break;

    case GetPhotosOfContact:
        //qDebug() << xmlData;
        emit photostreamUpdated(xmlData);
        break;        
        
    case GetRecentActivity:        
        qDebug() << xmlData;
        emit recentActivityUpdated(xmlData);
        break;
        
    case GetComments:
        //qDebug() << xmlData;
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
        //qDebug() << xmlData;
        emit favoritesUpdated(xmlData);
        break;
    
    case RemoveFavorite:
        emit favoriteRemoved();
        break;
        
    case GetUserInfo:
        qDebug()<< xmlData;
        emit userInfoUpdated(xmlData);
        break;
    case GetPhotoInfo:
        //qDebug()<< xmlData;
        emit photoInfoUpdated(xmlData);
        break;

    default:
        {
            if ( !err.code){
                qWarning()<<"Error: "<<err.message;
            }else{
                qWarning() << "Unknown Request!";
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












