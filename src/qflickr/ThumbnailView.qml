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
import QtQuick 2.15


Item{
    signal clicked( string photoId, url photoUrl )
    signal loadNextThumbnails()
    signal loadPreviousThumbnails()
    property alias model: grid.model
    property bool loading: false
    id: thumbnailView
    clip: true // clip left and right sides


    function loadMore(){
        if (grid.atYBeginning){
            loadPreviousThumbnails();
            console.log("prev page");
        }else
        if (grid.atYEnd){
            loadNextThumbnails();
            console.log("next page");
        }
    }


    GridView{
        id:             grid
        anchors.topMargin: settings.hugeMargin
        anchors.fill: parent
        cellHeight:     settings.pageWidth / 4
        cellWidth:      settings.pageWidth / 4
        delegate:       ThumbnailDelegate{onClicked: thumbnailView.clicked( photoId, photoUrl );}
        opacity: loading ?0.2:1
        onMovementEnded: loadMore();


        ScrollBar{
            scrollArea: parent
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
        }
    }

    Loading{
        anchors.centerIn: grid
        id: topLoadingIndicator
        visible: parent.loading
    }
}
