#ifndef FLICKRITEM_H
#define FLICKRITEM_H

#include <QObject>
#include <QUrl>
#include <QSize>
#include <QStringList>
class FlickrManager;
class FlickrItem : public QObject
{
Q_OBJECT
Q_PROPERTY(QString title READ title)// WRITE setTitle)
Q_PROPERTY(QString userName READ userName)// WRITE setUserName)
Q_PROPERTY(QUrl url READ url )//WRITE setUrl)
Q_PROPERTY(QString dateTaken READ dateTaken )//WRITE setDateTaken)
Q_PROPERTY(int thumbWidth READ thumbWidth )//WRITE setThumbWidth)
Q_PROPERTY(int thumbHeight READ thumbHeight )//WRITE setThumbHeight)
Q_PROPERTY(QSize thumbSize READ thumbSize )//WRITE setThumbSize)
Q_PROPERTY(QString owner READ owner )//WRITE setOwner)
Q_PROPERTY(QString description READ description )//WRITE setDescription)
Q_PROPERTY(QString tags READ tags )//WRITE setTags)
Q_PROPERTY(int views READ views )//WRITE setViews)
Q_PROPERTY(QString server READ server )//WRITE setServer)
Q_PROPERTY(QString farm READ farm )//WRITE setFarm)
Q_PROPERTY(QString id READ id)//WRITE setFarm)
Q_PROPERTY(QUrl flickrPhotoUrl READ flickrPhotoUrl )//WRITE setPhotoFlickrUrl)

public:
    explicit FlickrItem(FlickrManager *parent);
    virtual ~FlickrItem();

    QString title() const;
    void setTitle(const QString & title);

    QUrl url() const;
    void setUrl( const QUrl & url );

    QString userName() const;
    void setUserName(const QString & userName);

    QString dateTaken() const;
    void setDateTaken(const QString & dateTaken);

    int thumbWidth() const;
    void setThumbWidth( int width );

    int thumbHeight() const;
    void setThumbHeight( int height);

    QSize thumbSize() const;
    void setThumbSize( const QSize & size);

    QString owner() const;
    void setOwner( const QString & owner);

    QString description() const;
    void setDescription( const QString & descrption);

    int views() const;
    void setViews( int views );

    QString tags() const;
    void setTags( const QString & tags);

    QString server() const;
    void setServer( const QString & server);
    
    QString farm() const;
    void setFarm( const QString & farm);
    
    QString id() const;
    void setId( const QString & id);
    
    QUrl flickrPhotoUrl() const;
    
    
public Q_SLOTS:
    Q_INVOKABLE void requestUserPhotos();
    Q_INVOKABLE void openFlickrWeb();

Q_SIGNALS:
    void getUserPhotos( const QString & userId );

private:
    FlickrManager * m_parent;
    QString m_title;
    QUrl    m_url;
    QString m_userName;
    QString m_owner;
    QString m_dateTaken;
    QSize   m_thumbSize;
    QString m_description;
    int     m_views;
    QString m_tags;
    QString m_server;
    QString m_farm;
    QString m_id;

};

#endif // FLICKRITEM_H
