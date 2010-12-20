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
    
#ifdef Q_WS_MAEMO_5
    setAttribute(Qt::WA_Maemo5PortraitOrientation, true);
#endif

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

QmlLoader::~QmlLoader()
{
    delete m_flickrManager;
    m_flickrManager = 0;
}

void QmlLoader::minimize()
{
#ifdef Q_WS_MAEMO_5
     QDBusConnection c = QDBusConnection::sessionBus();
     QDBusMessage m = QDBusMessage::createSignal("/", "com.nokia.hildon_desktop", "exit_app_view");
     c.send(m);
#else
     showMinimized();
#endif
}








