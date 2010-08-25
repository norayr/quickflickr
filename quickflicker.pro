#-------------------------------------------------
#
# Project created by QtCreator 2010-03-20T10:56:57
#
#-------------------------------------------------


TARGET = quickflickr_
CONFIG   -= app_bundle
QT += declarative network xml opengl webkit

TEMPLATE = app

INCLUDEPATH += .

MOC_DIR = moc
OBJECTS_DIR = objs

SOURCES += main.cpp \
    qmlloader.cpp \
    flickrmanager.cpp \
    qtflickr.cpp \
    qtflickr_p.cpp     

HEADERS += \
    qmlloader.h \
    flickrmanager.h \
    qtflickr.h \
    qtflickr_p.h 


OTHER_FILES = \
    #qflickr/qmldir \
    qflickr/QuickFlickrMain.qml \
    qflickr/ContactList.qml \
    qflickr/ContactListDelegate.qml \
    qflickr/FullScreenViewer.qml \
    qflickr/FullScreenDelegate.qml \
    qflickr/Button.qml \
    qflickr/FlipableContactView.qml \
    qflickr/MainMenu.qml \
    qflickr/MenuButton.qml \    
    qflickr/RecentActivityView.qml \
    qflickr/WebBrowser.qml \
    qflickr/FlickableWebView.qml \
    qflickr/Header.qml \
    qflickr/ScrollBar.qml \
    qflickr/UrlInput.qml \
    qflickr/RecentActivityModel.qml \
    qflickr/RecentActivityDelegate.qml \
    qflickr/ContactListModel.qml \
    qflickr/FullScreenModel.qml
