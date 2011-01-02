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

Rectangle{
    anchors.fill: parent
    color: "black"

    Image{
        id: buddyIcon
        source: "http://farm"+iconfarm+".static.flickr.com/"+iconserver+"/buddyicons/"+nsid+".jpg"
        width: 48
        height: 48
        anchors.top:  parent.top
        anchors.topMargin: settings.largeMargin
        anchors.left: parent.left
        anchors.leftMargin: settings.largeMargin
    }
    Text{
        id: userName
        text: username
        color: "white"
        font.pixelSize: settings.largeFontSize
        verticalAlignment: Text.AlignTop
        smooth: true
        anchors.top: buddyIcon.top
        anchors.left: buddyIcon.right
        anchors.leftMargin: settings.largeMargin * 2
        anchors.right: parent.right
    }
    /*
    FlickrText{
        id: viewsText
        header: "Views"
        text:  views
        anchors.top:  userName.bottom        
        anchors.left: userName.left        
        fontPixelSize: settings.tinyFontSize
        Component.onCompleted: console.log("Views:"+views)
    }
    */
    FlickrText{
        id: photos
        header:  "Photos"
        text: count
        anchors.top: userName.bottom
        anchors.left: userName.left
        anchors.leftMargin: settings.mediumMargin
        fontPixelSize: settings.tinyFontSize
    }

    FlickrText{
        id: pro
        //visible: (ispro != 0)
        header: "Pro"
        text: (ispro != 0?"yes":"no")
        anchors.top: userName.bottom
        anchors.left: photos.right
        anchors.leftMargin: settings.mediumMargin
        fontPixelSize:  settings.tinyFontSize
    }

    FlickrText{
        id: dateTaken        
        header: "First upload"
        text: firstdatetaken // TODO: format this to shorter
        anchors.top:  buddyIcon.bottom
        anchors.topMargin: settings.mediumMargin
        anchors.left: buddyIcon.left
        anchors.right: userName.right
        fontPixelSize: settings.tinyFontSize
    }
    FlickrText{
        id: location        
        header:  "Location"
        text: (geolocation != ""? geolocation:"unknown")
        anchors.top:  dateTaken.bottom
        anchors.topMargin: settings.mediumMargin
        anchors.left: dateTaken.left
        anchors.right: dateTaken.right
        fontPixelSize: settings.tinyFontSize
    }
}
