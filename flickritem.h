#ifndef FLICKRITEM_H
#define FLICKRITEM_H

#include <QObject>
#include <QUrl>
#include <QSize>
class FlickrManager;
class FlickrItem : public QObject
{
Q_OBJECT
Q_PROPERTY(QString title READ title WRITE setTitle)
Q_PROPERTY(QString userName READ userName WRITE setUserName)
Q_PROPERTY(QUrl url READ url WRITE setUrl)
Q_PROPERTY(QString dateTaken READ dateTaken WRITE setDateTaken)
Q_PROPERTY(int thumbWidth READ thumbWidth WRITE setThumbWidth)
Q_PROPERTY(int thumbHeight READ thumbHeight WRITE setThumbHeight)
Q_PROPERTY(QSize thumbSize READ thumbSize WRITE setThumbSize)

public:
    explicit FlickrItem(FlickrManager *parent);

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


    Q_INVOKABLE void requestUserPhotos();

Q_SIGNALS:
    void getUserPhotos( const QString & userId );

private:
    FlickrManager * m_parent;
    QString m_title;
    QUrl    m_url;
    QString m_userName;
    QString m_dateTaken;
    QSize   m_thumbSize;
};

#endif // FLICKRITEM_H
