#include "flickritem.h"
#include "flickrmanager.h"
#include <QtDebug>

FlickrItem::FlickrItem(FlickrManager *parent) :
    QObject(parent),
    m_parent( parent ),
    m_title(),
    m_url(),
    m_userName()
{
}


QString FlickrItem::title() const
{
    return m_title;
}

void FlickrItem::setTitle(const QString & title)
{
    m_title = title;
}

QUrl FlickrItem::url() const
{
    return m_url;
}

void FlickrItem::setUrl( const QUrl & url )
{
    m_url = url;
}

QString FlickrItem::userName() const
{
    return m_userName;
}

void FlickrItem::setUserName(const QString & userName)
{
    m_userName = userName;
}

QString FlickrItem::dateTaken() const
{
    return m_dateTaken;
}

void FlickrItem::setDateTaken(const QString & dateTaken)
{
    m_dateTaken = dateTaken;
}

int FlickrItem::thumbWidth() const
{
    return m_thumbSize.width();
}

void FlickrItem::setThumbWidth( int width )
{
    m_thumbSize.setWidth( width );
}

int FlickrItem::thumbHeight() const
{
    return m_thumbSize.height();
}

void FlickrItem::setThumbHeight( int height)
{
    return m_thumbSize.setHeight( height );
}

QSize FlickrItem::thumbSize() const
{
    return m_thumbSize;
}

void FlickrItem::setThumbSize( const QSize & size)
{
    m_thumbSize = size;
}

void FlickrItem::requestUserPhotos()
{
    qDebug() << "requesting user photos for user: " << m_userName;
    emit getUserPhotos( m_userName );
}




