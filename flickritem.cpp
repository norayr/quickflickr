#include "flickritem.h"
#include "flickrmanager.h"
#include <QtDebug>
#include <QDesktopServices>

FlickrItem::FlickrItem(FlickrManager *parent) :
    QObject(parent),
    m_parent( parent ),
    m_title(),
    m_url(),
    m_userName(),
    m_owner(),
    m_dateTaken(),
    m_thumbSize(),
    m_description(),
    m_views(),
    m_tags()

{
    setObjectName("flickrItem");
}

FlickrItem::~FlickrItem()
{
    qDebug() << "Deleting flickr item";
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

QString FlickrItem::owner() const
{
    return m_owner;
}

void FlickrItem::setOwner( const QString & owner)
{
    m_owner = owner;
}

QString FlickrItem::description() const
{
    return m_description;
}

void FlickrItem::setDescription( const QString & description)
{
    m_description = description;
}

int FlickrItem::views() const
{
    return m_views;
}

void FlickrItem::setViews( int views )
{
    m_views = views;
}

QString FlickrItem::tags() const
{
    return m_tags;
}
void FlickrItem::setTags( const QString & tags)
{
    m_tags = tags;
}

QString FlickrItem::server() const
{
    return m_server;
}

void FlickrItem::setServer( const QString & server)
{
    m_server = server;
}

QString FlickrItem::farm() const
{
    return m_farm;
}

void FlickrItem::setFarm( const QString & farm)
{
     m_farm = farm;
}

QString FlickrItem::id() const
{
    return m_id;
}

void FlickrItem::setId( const QString & id)
{
    m_id = id;
}

QString FlickrItem::flickrPhotoUrl() const
{
    return QUrl("http://www.flickr.com/photos/"+m_owner+"/"+m_id).toString(); 
}




void FlickrItem::requestUserPhotos()
{
    emit getUserPhotos( m_userName );
}

void FlickrItem::openFlickrWeb()
{
    QDesktopServices::openUrl(flickrPhotoUrl());
}
