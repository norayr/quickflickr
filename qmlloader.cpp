#include "qmlloader.h"
#include "flickrmanager.h"

#include <QDeclarativeError>
#include <QDeclarativeContext>
#include <QHBoxLayout>
#include <QtDebug>

QmlLoader::QmlLoader():
        QWidget(),
        m_view(0)
{
    QHBoxLayout * layout = new QHBoxLayout;
    layout->setContentsMargins(0,0,0,0);
    m_view = new QDeclarativeView(this);
    connect( m_view, SIGNAL(statusChanged(QDeclarativeView::Status)),
             this, SLOT(statusChanged(QDeclarativeView::Status)));
    layout->addWidget(m_view);

    QUrl url("QuickFlickrMain.qml");
    m_view->setSource(url);
    setLayout(layout);

    m_flickrManager = new FlickrManager();
    connect(m_flickrManager, SIGNAL(modelUpdated()),
            this, SLOT(modelUpdated()));
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

void QmlLoader::modelUpdated()
{
    qDebug() << "QmlLoader::modelUpdated";
    QList<QObject*> model = m_flickrManager->model();
    QDeclarativeContext *ctxt = m_view->rootContext();
    ctxt->setContextProperty("contactModel", QVariant::fromValue(model));
}

