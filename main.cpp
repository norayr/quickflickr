#include <QApplication>
#include "qmlloader.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    // Simple loader for loading QML files
    QmlLoader loader;
    loader.resize(800,480);
    loader.show();
    return a.exec();
}
