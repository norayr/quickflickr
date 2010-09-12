#include <QApplication>
#include "qmlloader.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    Q_INIT_RESOURCE(quickflickr);
    
    // Simple loader for loading QML files
    QmlLoader loader;
    loader.resize(800,480);
#ifdef Q_WS_MAC
        loader.show();
#else
        app.setGraphicsSystem("raster");
        loader.showFullScreen();
#endif
    
    return a.exec();
}
