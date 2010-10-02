#-------------------------------------------------
#
# Project created by QtCreator 2010-03-20T10:56:57
#
#-------------------------------------------------


TARGET = quickflickr
CONFIG   -= app_bundle release
QT += declarative network xml opengl webkit dbus


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
    qflickr/FullScreenModel.qml \
    qflickr/CommentsView.qml \
    qflickr/CommentModel.qml \
    qflickr/CommentDelegate.qml \
    qflickr/FavoritesView.qml \
    qflickr/FavoritesModel.qml \
    qflickr/FavoriteDelegate.qml \
    qflickr/FlickrImage.qml \
    qflickr/BrowserButton.qml \
    qflickr/Loading.qml \
    qflickr/Page.qml \
    qflickr/NavigationBar.qml \
    qflickr/FullScreenInfoField.qml \
    qflickr/CommentList.qml \
    qflickr/FullScreenCommentField.qml




RESOURCES += \
    quickflickr.qrc
