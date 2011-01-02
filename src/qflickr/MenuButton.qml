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
    id: menuButton
    property alias text: menuButtonText.text
    signal clicked

    width: 134
    height: 134
    state: "Default"

    Image{
        id: background
        source: "qrc:///gfx/gfx/menu-button.png"
        smooth: true
        opacity: 0.2
        anchors.fill: parent
    }

    Text{
        id: menuButtonText
        anchors.fill: parent
        font.family: "Helvetica"; font.pixelSize: 22;
        color: "white"
        smooth: true
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    MouseArea{
        id: mouseRegion
        anchors.fill: parent
        onPressed: menuButton.state = 'Pressed'
        onReleased: menuButton.state = 'Default'
        onClicked: { menuButton.clicked(); }
    }

    states:[
    State {
      name: "Pressed"
      when: mouseRegion.pressed == true
      PropertyChanges {
          target: menuButtonText
          style: Text.Sunken
          color: "gray"
      }
    }
    ]


}
