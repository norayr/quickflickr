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
    id: navBar    
    property alias model: menu.model
    property int currentIndex: 0
    signal itemSelected(string id)

    height: settings.navigationBarHeight

    Image{
        source: "qrc:/gfx/navigationbar-bg.png"
        anchors.fill: parent
        fillMode: Image.TileHorizontally
    }


    Component{
        id: ldelegate


        Text{
            width: menu.width
            height: menu.height
            text: name
            color: "white"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            smooth: true

            Behavior on scale { NumberAnimation { duration: 200 } }

            MouseArea{
                anchors.fill: parent
                onPressed: {parent.scale = 0.9; }
                onReleased: { parent.scale = 1 }
                onClicked: navBar.itemSelected(strId)
            }
        }
    }



    // List view for containing the actual menu items
    ListView{
        id: menu        
        delegate: ldelegate
        anchors.fill: parent
        anchors.bottomMargin: 30
        orientation: ListView.Horizontal
        snapMode: ListView.SnapOneItem
        highlightRangeMode: ListView.StrictlyEnforceRange
        currentIndex: navBar.currentIndex
        onCurrentIndexChanged: navBar.currentIndex = currentIndex
    }




    Row{
        anchors.top: menu.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: menu.horizontalCenter


        Repeater{
            model: lmodel.count
            Image{                
                smooth:  true
                source: menu.currentIndex == index?"qrc:/gfx/indicator-selected.png":"qrc:/gfx/indicator-not-selected.png"
                width:  25
                height: 25
                fillMode: Image.PreserveAspectFit                

            }
        }
    }    
    
}
