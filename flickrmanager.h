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
        RequestCount

    };

    FlickrManager();

    virtual ~ FlickrManager();

    void authenticate();

    void getFrob();

    void getLatestContactUploads();

    void getPhotosOfContact(const QString & userId);

    QList<QObject*> model() const;

Q_SIGNALS:
    void modelUpdated();

public Q_SLOTS:        
    void requestFinished ( int reqId, QtfResponse data, QtfError err, void* userData );

private:
    FlickrManagerPrivate * d_ptr;
    Q_DECLARE_PRIVATE( FlickrManager );
};

#endif // FLICKRMANAGER_H
