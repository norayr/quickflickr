/**
 * QuickFlickr - FlickrClient for mobile devices.
 *
 * Author: Marko Mattila (marko.mattila@d-pointer.com)
 *         http://www.d-pointer.com
 *
 *  QuickFlickr is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuickFlickr is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with QuickFLickr.  If not, see <http://www.gnu.org/licenses/>.
 */
#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHBoxLayout>
#include <QtDebug>

#ifndef Q_OS_SYMBIAN
#include <QGLContext>
#endif

#ifdef Q_WS_MAEMO_5
#include <QDBusConnection>
#include <QDBusMessage>
#endif

#ifdef Q_OS_SYMBIAN
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

#ifdef Q_OS_SYMBIAN
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








