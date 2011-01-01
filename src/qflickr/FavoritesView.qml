import Qt 4.7

Item{
    property bool loading: false
    property int currentPage: 1
    property int perPage: 24
    signal thumbnailClicked( string photoId, url photoUrl )

    // Function to get next photostream page
    function nextFavoritesPage()
    {
        loading = true;
        ++currentPage;

        if ( favoritesModel.count < perPage )
            return;

        favoritesModel.xml = "";
        flickrManager.getFavorites( perPage, currentPage );
    }

    // Function to get previous photostream page
    function prevFavoritesPage()
    {
        if ( currentPage == 1)
            return;
        loading = true;
        --currentPage;
        favoritesModel.xml = "";
        flickrManager.getFavorites(perPage, currentPage );
    }

    FavoritesModel{
        id: favoritesModel
    }


    // Connections to the C++ interface
    Connections{
        target: flickrManager
        onFavoritesUpdated: { favoritesModel.xml = xml; loading = false; }
    }

    ThumbnailView{
        anchors.top:    parent.top
        anchors.topMargin: 5
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        model: favoritesModel
        loading: parent.loading
        onClicked: parent.thumbnailClicked(photoId, photoUrl );
        onLoadNextThumbnails: nextFavoritesPage();
        onLoadPreviousThumbnails: prevFavoritesPage();
    }
}
