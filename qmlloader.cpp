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

    
    // Setup the C++ side for providing data for QML
    m_flickrManager = new FlickrManager();
    //bool isAuthenticated = m_flickrManager->isAuthenticated();
        
    connect(m_flickrManager, SIGNAL(modelUpdated(QList<QObject*>)),
            this, SLOT(modelUpdated(QList<QObject*>)), Qt::QueuedConnection);

    connect(m_flickrManager, SIGNAL(photoStreamModelUpdated(QList<QObject*>)),
            this, SLOT(photoStreamModelUpdated(QList<QObject*>)));

    
    /*
    if ( isAuthenticated ){
        m_flickrManager->getLatestContactUploads();        
    }
    */
        
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

void QmlLoader::modelUpdated( const QList<QObject*> & model)
{
    qDebug() << "QmlLoader::modelUpdated";
    //QList<QObject*> model = m_flickrManager->model();
    QDeclarativeContext *ctxt = m_view->rootContext();
    ctxt->setContextProperty("contactModel", QVariant::fromValue(model));
}

void QmlLoader::photoStreamModelUpdated(  const QList<QObject*> & model )
{
    qDebug() << "QmlLoader::PhotoStreamModelUpdated";
    //QList<QObject*> model = m_flickrManager->photoStreamModel();
    QDeclarativeContext *ctxt = m_view->rootContext();
    ctxt->setContextProperty("photoStreamModel", QVariant::fromValue(model));
}

void QmlLoader::localImageModelUpdated()
{
    qDebug() << "QmlLoader::localImageModelUpdated";
    /*
    QList<QObject*> model = m_localImageManager->model();
    QDeclarativeContext *ctxt = m_view->rootContext();
    ctxt->setContextProperty("localImageModel", QVariant::fromValue(model));
    */
}

void QmlLoader::recentActivityUpdated()
{
    qDebug() << "QmlLoad::recentActivityUpdated.. NOT IMPLEMENTED!";
    
}









