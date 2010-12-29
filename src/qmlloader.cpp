#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHBoxLayout>
#include <QtDebug>
#include <QGLContext>

#ifdef Q_WS_MAEMO_5
#include <QDBusConnection>
#include <QDBusMessage>
#endif

#if defined(Q_OS_SYMBIAN)
#include <eikenv.h>
#include <eikappui.h>
#include <aknenv.h>
#include <aknappui.h>
#endif

QmlLoader::QmlLoader():
        QDeclarativeView()       
{

// Set the platform specific orientations to portrait always
#ifdef Q_WS_MAEMO_5
    setAttribute(Qt::WA_Maemo5PortraitOrientation, true);
#endif

#ifdef Q_WS_SYMBIAN
    CAknAppUi* appUi = dynamic_cast<CAknAppUi*> (CEikonEnv::Static()->AppUi());
    if (appUi){
        appUi->SetOrientationL(CAknAppUi::EAppUiOrientationPortrait);
    }
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








