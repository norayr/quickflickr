#-------------------------------------------------
#
# Project created by QtCreator 2010-03-20T10:56:57
#
#-------------------------------------------------


TARGET = quickflickr
CONFIG   -= app_bundle release
QT += declarative network xml opengl webkit #dbus


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


OTHER_FILES += \    
    qflickr/QuickFlickrMain.qml \
    qflickr/Button.qml \
    qflickr/MainMenu.qml \
    qflickr/MenuButton.qml \    
    qflickr/WebBrowser.qml \
    qflickr/FlickableWebView.qml \
    qflickr/Header.qml \
    qflickr/ScrollBar.qml \
    qflickr/UrlInput.qml \
    qflickr/RecentActivityModel.qml \
    qflickr/ContactListModel.qml \
    qflickr/CommentModel.qml \
    qflickr/FavoritesModel.qml \
    qflickr/FlickrImage.qml \
    qflickr/BrowserButton.qml \
    qflickr/Loading.qml \
    qflickr/Page.qml \
    qflickr/NavigationBar.qml \
    qflickr/Settings.qml \
    qflickr/Timelineview.qml \
    qflickr/TimelineDelegate.qml \
    qflickr/PhotostreamView.qml \
    qflickr/PhotostreamModel.qml \
    qflickr/PhotoDetailsView.qml \
    qflickr/UserInfoModel.qml \
    qflickr/UserInfoDelegate.qml





RESOURCES += \
    quickflickr.qrc
