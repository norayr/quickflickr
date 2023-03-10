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

Rectangle {
    color: "black"
    width: settings.pageWidth
    height: settings.pageHeight

    Column{
        anchors.fill: parent
        anchors.margins: settings.mediumMargin
        spacing: settings.mediumMargin

        Text{
            color: "white"
            font.pixelSize: settings.largeFontSize
            text: "Settings"
            smooth: true
        }

        FlickrText{
            id: logInfo            
            smooth: true
            header: "You are logged in as"
            Connections{
                target: flickrManager
                onProceed: logInfo.text = flickrManager.userName();
            }
        }

        Button{            
            text: "Log out"
            onClicked:  flickrManager.removeAuthentication()
        }

        Item{
            height: settings.hugeMargin * 3
            width: settings.pageWidth
        }

        Image{
            source: "qrc:/gfx/d-pointer-logo.png"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text{
            color: "white"
            font.pixelSize: settings.largeFontSize
            text: "About"
            smooth:  true
        }

        Text{
            color: "white"
            font.pixelSize: settings.smallFontSize
            text:   "QuickFlickr is brought you by <a href=\"http://www.d-pointer.com\">d-pointer</a>. " +
                    "QuickFlickr is an open source application and you are free to use and redistribute it as stated in LGPL license." +
                    "<br><br>" +
                    "If you want to give us feedback, you can send us email: <a href=\"mailto:info@d-pointer.com\">info@d-pointer.com</a>."


            textFormat: Text.RichText
            wrapMode:  Text.Wrap
            width: parent.width
            onLinkActivated:Qt.openUrlExternally(link);
            smooth: true
        }

    }
}
