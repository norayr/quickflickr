#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHBoxLayout>
#include <QtDebug>
#include <QGLContext>

QmlLoader::QmlLoader():
        QDeclarativeView()       
{
    
    
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);
    QGLWidget *glWidget = new QGLWidget(format);
    glWidget->setAutoFillBackground(false);
    setViewport(glWidget);
    
    

    connect(engine(),SIGNAL(quit()),qApp,SLOT(quit()));
    
    // Setup the C++ side for providing data for QML
    m_flickrManager = new FlickrManager();    
        
    
    // Expose the C++ interface to QML
    engine()->rootContext()->setContextProperty("flickrManager", m_flickrManager );
    
    
    // Load the main QML component which constructs the whole UI from other
    // QML components    
    setSource(QUrl("qrc:///qml/qflickr/QuickFlickrMain.qml"));    
    m_flickrManager->activate();
}








