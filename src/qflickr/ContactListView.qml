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
    id: contactListView
    // Signal for indicating that user has been clicked
    signal clicked(string nsid)
    property bool isModelUpdated: false

    width: settings.pageWidth

    Connections{
        target: flickrManager
        onContactsUpdated: {contactListModel.xml = xml; isModelUpdated = true;}
    }

    ContactListModel{
        id: contactListModel
    }

    Component{
        id: cdelegate
        Item{
            width: settings.pageWidth
            height:  childrenRect.height
            opacity:  0
            Behavior on opacity { PropertyAnimation { duration: 400 } }
            MouseArea{
                anchors.fill: parent
                onClicked: contactListView.clicked( nsid );
            }

            Rectangle{
                id: contactListBg
                color: "#00000000"
                //border.color: "lightGray"
                //border.width: 1
                anchors.fill: parent
                //anchors.rightMargin: 1
            }
            Image{
                id: buddyIcon
                anchors.top: contactListBg.top
                anchors.left: contactListBg.left
                anchors.margins: settings.mediumMargin
                source: "http://farm"+iconfarm+".static.flickr.com/"+iconserver+"/buddyicons/"+nsid+".jpg";
                onStatusChanged: (status == Image.Ready || status == Image.Error)?parent.opacity = 1:parent.opacity = 0;
                width: 48 // Size is defined by Flickr
                height: 48
            }
            Text{
                id: userName
                anchors.left: buddyIcon.right
                anchors.top:  buddyIcon.top
                anchors.leftMargin: settings.mediumMargin
                color: "white"
                font.pixelSize: settings.mediumFontSize
                text: username
                elide: Text.ElideRight
                width: parent.width - buddyIcon.width
            }
            Text{
                id: realName
                anchors.left: buddyIcon.right
                anchors.top:  userName.bottom
                anchors.leftMargin: settings.mediumMargin
		anchors.topMargin: settings.smallMargin
                color: "white"
                text: realname
                elide: Text.ElideRight
                width: parent.width - buddyIcon.width
            }
            LineSeparator{
                width:  parent.width
                thickness: 1
                anchors.top: realName.bottom
                anchors.topMargin: settings.mediumMargin
            }
        }
    }

    ListView{
        id: contactList
        anchors.fill: parent
        delegate: cdelegate
        model: contactListModel
        cacheBuffer: contactList.height
        clip: true
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

    Item{
        anchors.fill: contactList
        visible:  contactListModel.xml == ""
         Loading{
             id: loader
             anchors.centerIn: parent
         }
    }
}
