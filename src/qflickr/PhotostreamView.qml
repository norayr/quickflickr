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
