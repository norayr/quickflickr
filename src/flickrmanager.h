#ifndef FLICKRMANAGER_H
#define FLICKRMANAGER_H

#include <QObject>
#include "qtflickr.h"

class FlickrManagerPrivate;


class FlickrManager : public QObject
{
    Q_OBJECT    

public:
    enum RequestId
    {
        GetFrob,
        GetToken,
        GetContactsPublicPhotos,
        GetPhotosOfContact,
        GetRecentActivity,
        GetComments,
        AddComment,
        AddFavorite,
        GetFavorites,
        RemoveFavorite,
        GetUserInfo,
        GetPhotoInfo,
        RequestCount

    };

    FlickrManager();

    virtual ~ FlickrManager();

    Q_INVOKABLE void activate();
    
    Q_INVOKABLE void authenticate();

    Q_INVOKABLE void getLatestContactUploads();

    Q_INVOKABLE void getPhotostream(const QString & userId, int page=1);

    Q_INVOKABLE void getUserInfo(const QString & userId);

    Q_INVOKABLE void getRecentActivity();
    
    Q_INVOKABLE void getToken();
        
    Q_INVOKABLE bool isAuthenticated() const;
    
    Q_INVOKABLE void getComments( const QString & photoId );

    Q_INVOKABLE void addComment(const QString & photoId, const QString & commentText );

    Q_INVOKABLE void addFavorite( const QString & photoId );
    
    Q_INVOKABLE void getFavorites();
    
    Q_INVOKABLE void removeFavorite( const QString & photoId );
    
    Q_INVOKABLE void getPhotoInfo(const QString & photoId );

    Q_INVOKABLE QString nsid() const;

Q_SIGNALS:
    void authenticationRequired(const QUrl & authUrl);
    void proceed();        
    void contactsUploadsUpdated(const QString & xml);
    void photostreamUpdated( const QString & xml);
    void recentActivityUpdated( const QString & xml);
    void commentsUpdated( const QString & xml);
    void commentAdded();
    void favoritesUpdated( const QString & xml);
    void favoriteRemoved();
    void userInfoUpdated( const QString & xml);
    void photoInfoUpdated( const QString & xml);

private Q_SLOTS:        
    void requestFinished ( int reqId, QtfResponse data, QtfError err, void* userData );
    void requestFinished ( int reqId, QString xmlData, QtfError err, void* userData );
    
private:
    FlickrManagerPrivate * d_ptr;
    Q_DECLARE_PRIVATE( FlickrManager );
};

#endif // FLICKRMANAGER_H






