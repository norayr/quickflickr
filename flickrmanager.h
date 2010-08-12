#ifndef FLICKRMANAGER_H
#define FLICKRMANAGER_H

#include <QObject>
#include "qtflickr.h"

class FlickrManagerPrivate;
class QAbstractItemModel;
class FlickrItem;

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
        RequestCount

    };

    FlickrManager();

    virtual ~ FlickrManager();

    Q_INVOKABLE void activate();
    
    void authenticate();

    void getFrob();

    Q_INVOKABLE void getLatestContactUploads();

    Q_INVOKABLE void getPhotosOfContact(const QString & userId);

    Q_INVOKABLE void getRecentActivity();
    
    QList<QObject*> model() const;

    QList<QObject*> photoStreamModel() const;
    
    bool isAuthenticated() const;

Q_SIGNALS:
    void modelUpdated(const QList<QObject*> & model);
    void photoStreamModelUpdated(const QList<QObject*> & model);

private Q_SLOTS:        
    void requestFinished ( int reqId, QtfResponse data, QtfError err, void* userData );

private:
    FlickrManagerPrivate * d_ptr;
    Q_DECLARE_PRIVATE( FlickrManager );
};

#endif // FLICKRMANAGER_H






