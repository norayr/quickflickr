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
//import QtQuick 2.15
import QtQuick 2.15

Item{
    id: addCommentView
    // An id for photo to which comment will be added
    property string photoId
    signal commentAdded()
    onPhotoIdChanged: clear() // Clear the old crap if photo id changes
    width: settings.pageWidth

    function clear(){
        commentText.text = "";
    }

    function addComment( text)
    {
        if (photoId == ""){
            console.log("Can't add comment. Photo id is empty");
            return;
        }

        if (text == ""){
            console.log("Can't add comment. Comment string is empty");
            return;
        }

        flickrManager.addComment(photoId, text);
        addCommentView.clear();
        addCommentView.commentAdded();
    }

    Rectangle {
        id: addCommentBg
        color: "black"
        opacity: 0.8
        anchors.fill: parent
        visible: false
    }

    Text{
        id: addCommentTitle
        text: "Add Comment:"
        font.pixelSize: settings.mediumFontSize
        color: settings.fontColor
        anchors.top: addCommentBg.top
        anchors.topMargin: settings.mediumMargin
        anchors.left: addCommentBg.left
        anchors.right: addCommentBg.right
    }

    Rectangle{
        id: textEditBg
        //anchors.top: addCommentTitle.bottom
        anchors.left: addCommentBg.left
        anchors.right: addCommentBg.right
        //anchors.bottom: addCommentBg.bottom
        //anchors.topMargin: settings.largeMargin * 2
        anchors.leftMargin: settings.mediumMargin
        anchors.rightMargin: settings.mediumMargin
        //anchors.bottomMargin: settings.largeMargin * 2
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 2
        color:  "white"
        radius: 15
        smooth: true
        border.width: 1
        border.color: "blue"
        opacity: 0.5
    }
    TextEdit {
        id: commentText
        anchors.fill: textEditBg
        anchors.topMargin: settings.mediumMargin
        anchors.leftMargin: settings.mediumMargin
        anchors.rightMargin: settings.mediumMargin
        anchors.bottomMargin: settings.mediumMargin
        font.pixelSize: settings.mediumFontSize
        color: "black"
        //focus: true
        width: textEditBg.width
        wrapMode: TextEdit.Wrap
        clip: true
    }

    Button{
        id: addCommentButton
        //anchors.top: textEditBg.bottom
        //anchors.topMargin: settings.largeMargin
        anchors.top: textEditBg.bottom
        anchors.topMargin: settings.largeMargin
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Add"
        onClicked: addComment(commentText.text);
    }

}
