/**
 * QuickFlickr - Flickr client for mobile devices.
 *
 * Author: Marko Mattila (marko.mattila@d-pointer.com)
 *         http://www.d-pointer.com
 *
 *  QuickFlickr is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuickFlickr is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with QuickFLickr.  If not, see <http://www.gnu.org/licenses/>.
 */
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
