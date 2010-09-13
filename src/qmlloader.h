#ifndef QMLLOADER_H
#define QMLLOADER_H


#include <QDeclarativeView>


class FlickrManager;
class QmlLoader: public QDeclarativeView
{
    Q_OBJECT
public:
    QmlLoader();
    virtual ~QmlLoader();
    
public slots:
    void minimize();
    
private:
    FlickrManager    * m_flickrManager;    
};

#endif // QMLLOADER_H
