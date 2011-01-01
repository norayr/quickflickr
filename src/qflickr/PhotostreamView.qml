import Qt 4.7

Rectangle {
    id: photostreamView
    width:  settings.pageWidth
    height: settings.pageHeight
    color:  settings.defaultBackgroundColor

    signal thumbnailClicked( string photoId, url photoUrl )
    property int currentPage: 1
    property string userid
    property bool loading: true

    PhotostreamModel{
        id: photostreamModel
    }

    UserInfoModel{
        id: userInfoModel
    }

    // Connections to the C++ interface
    Connections{
        target: flickrManager
        onPhotostreamUpdated: { photostreamModel.xml = xml; loading = false;}
        onUserInfoUpdated: { userInfoModel.xml = xml}
    }

    // Function to get next photostream page
    function nextPhotostreamPage()
    {
        loading = true;
        ++currentPage;        
        flickrManager.getPhotostream( userid, currentPage );
    }

    // Function to get previous photostream page
    function prevPhotostreamPage()
    {
        if ( currentPage == 1)
            return;
        loading = true;
        --currentPage;
        flickrManager.getPhotostream( userid, currentPage );
    }


    // Because we get all the user data also in XML, let's create a view
    // for a single user information
    ListView{
        id:spacer
        height: 110
        width:  parent.width
        interactive: false
        anchors.top: parent.top
        model:  userInfoModel
        delegate:  UserInfoDelegate{}
    }

    // Grid for thumbnails
    ThumbnailView{
        anchors.top:    spacer.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        model: photostreamModel
        loading: parent.loading
        onClicked: parent.thumbnailClicked(photoId, photoUrl );
        onLoadNextThumbnails: nextPhotostreamPage();
        onLoadPreviousThumbnails: prevPhotostreamPage();
    }
}
