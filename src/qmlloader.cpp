#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHBoxLayout>
#include <QtDebug>
#include <QGLContext>

#ifndef Q_WS_MAC
#include <QDBusConnection>
#include <QDBusMessage>
#endif

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
    engine()->rootContext()->setContextProperty("mainWindow", this );
    
    // Load the main QML component which constructs the whole UI from other
    // QML components    
    setSource(QUrl("qrc:///qml/qflickr/QuickFlickrMain.qml"));    
    m_flickrManager->activate();
}


void QmlLoader::minimize()
{
#ifndef Q_WS_MAC
     QDBusConnection c = QDBusConnection::sessionBus();
     QDBusMessage m = QDBusMessage::createSignal("/", "com.nokia.hildon_desktop", "exit_app_view");
     c.send(m);
#else
     showMinimized();
#endif
}








