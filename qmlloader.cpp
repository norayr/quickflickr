#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHBoxLayout>
#include <QtDebug>
#include <QGLContext>

QmlLoader::QmlLoader():
        QWidget(),
        m_view(0)
{
    QHBoxLayout * layout = new QHBoxLayout;
    layout->setContentsMargins(0,0,0,0);
    m_view = new QDeclarativeView(this);

    // Make sure that we use OpenGL    
    
    QGLFormat format = QGLFormat::defaultFormat();
    format.setSampleBuffers(false);
    QGLWidget *glWidget = new QGLWidget(format);
    glWidget->setAutoFillBackground(false);
    m_view->setViewport(glWidget);
    
    connect( m_view, SIGNAL(statusChanged(QDeclarativeView::Status)),
             this, SLOT(statusChanged(QDeclarativeView::Status)));
    layout->addWidget(m_view);

    connect(m_view->engine(),SIGNAL(quit()),qApp,SLOT(quit()));
    
    // Setup the C++ side for providing data for QML
    m_flickrManager = new FlickrManager();    
        
    
    // Expose the C++ interface to QML
    m_view->engine()->rootContext()->setContextProperty("flickrManager", m_flickrManager );
    
    
    // Load the main QML component which constructs the whole UI from other
    // QML components
    QUrl url("qflickr/QuickFlickrMain.qml");
    m_view->setSource(url);
    setLayout(layout);
    QMetaObject::invokeMethod(m_flickrManager, "activate");
        
}


void QmlLoader::statusChanged ( QDeclarativeView::Status status )
{
    switch( status ){
    case QDeclarativeView::Error:
        {
            QList<QDeclarativeError> errors =  m_view->errors();
            Q_FOREACH( QDeclarativeError error, errors){
                qWarning() << error.toString();
            }
        }
        break;

    case QDeclarativeView::Ready:
        qDebug() << "QmlLoader is Ready";
        show();
        break;
    case QDeclarativeView::Loading:
        qDebug() << "QmlLoader is loading...";
        break;
    case QDeclarativeView::Null:
        qDebug() << "QmlLoader is null";;
        break;
    }
}








