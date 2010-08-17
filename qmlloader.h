#ifndef QMLLOADER_H
#define QMLLOADER_H

#include <QWidget>
#include <QDeclarativeView>


class FlickrManager;
class QmlLoader: public QWidget
{
    Q_OBJECT
public:
    QmlLoader();


private Q_SLOTS:
    void statusChanged ( QDeclarativeView::Status status );
    void contactModelUpdated( const QList<QObject*> & model);
    void photoStreamModelUpdated( const QList<QObject*> & model );
    void localImageModelUpdated();
    void recentActivityUpdated();
    
private:
    QDeclarativeView * m_view;
    FlickrManager    * m_flickrManager;    
};

#endif // QMLLOADER_H
