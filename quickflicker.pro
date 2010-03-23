#-------------------------------------------------
#
# Project created by QtCreator 2010-03-20T10:56:57
#
#-------------------------------------------------


TARGET = QuickFlickr
CONFIG   -= app_bundle
QT += declarative network xml

TEMPLATE = app

INCLUDEPATH += .

MOC_DIR = moc
OBJECTS_DIR = objs

SOURCES += main.cpp \
    qmlloader.cpp \
    flickrmanager.cpp \
    flickritem.cpp \
    qtflickr.cpp \
    qtflickr_p.cpp

HEADERS += \
    qmlloader.h \
    flickrmanager.h \
    flickritem.h \
    qtflickr.h \
    qtflickr_p.h


OTHER_FILES = ContactList.qml \
    QuickFlickrMain.qml \
    FlickrItemDelegate.qml \
    FullScreenViewer.qml \
    FullScreenDelegate.qml \
    Button.qml
