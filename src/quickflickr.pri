#-------------------------------------------------
#
# Project created by QtCreator 2010-03-20T10:56:57
#
#-------------------------------------------------


TARGET = quickflickr
CONFIG   -= app_bundle release
#QT += declarative network xml webkit
QT += network xml webkit widgets qml quick
QMAKE_CXXFLAGS = -O2
mac{
    QT += opengl
}

maemo5{
    QT += dbus opengl
}

symbian{
    LIBS += -lavkon -leikcore -lcone
    TARGET.CAPABILITY += NetworkServices
    TARGET.EPOCHEAPSIZE = 0x20000 0x8000000
    #TARGET.EPOCSTACKSIZE = 0x80000
    #TARGET.EPOCALLOWDLLDATA = 1
    default_deployment.pkg_prerules += pkg_depends_webkit
}


TEMPLATE = app

INCLUDEPATH += .

MOC_DIR = moc
OBJECTS_DIR = objs

SOURCES += main.cpp \
    qmlloader.cpp \
    flickrmanager.cpp \
    qtflickr.cpp \
    qtflickr_p.cpp \     
    deviceprofile.cpp

HEADERS += \
    qmlloader.h \
    flickrmanager.h \
    qtflickr.h \
    qtflickr_p.h \ 
    deviceprofile.h


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
    qflickr/CommentModel.qml \
    qflickr/CommentsView.qml \
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
    qflickr/UserInfoDelegate.qml \
    qflickr/FlickrText.qml \
    qflickr/LineSeparator.qml \
    qflickr/IconButton.qml \
    qflickr/RadioIconButton.qml \
    qflickr/PhotoDetailsModel.qml \
    qflickr/PhotoDetailsDelegate.qml \
    qflickr/AddCommentView.qml \
    qflickr/ContactUploadsModel.qml \
    qflickr/ContactListModel.qml \
    qflickr/ContactListView.qml \
    qflickr/FavoritesView.qml \
    qflickr/ThumbnailDelegate.qml \
    qflickr/ThumbnailView.qml \
    qflickr/RecentActivityView.qml \
    qflickr/SettingsView.qml \
    qflickr/AuthenticationView.qml





RESOURCES += \
    quickflickr.qrc
