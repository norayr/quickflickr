#include <QApplication>
#include "qmlloader.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    Q_INIT_RESOURCE(quickflickr);
    
    // Simple loader for loading QML files
    QmlLoader loader;
    loader.resize(480,800);
#ifdef Q_WS_MAC
        loader.show();
#else
        app.setGraphicsSystem("raster");
        loader.showFullScreen();
#endif
    return app.exec();
}
