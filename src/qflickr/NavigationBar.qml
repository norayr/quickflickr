import Qt 4.7

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
        anchors.bottomMargin: 20
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
                width:  15
                height: 15
                fillMode: Image.PreserveAspectFit
            }
        }
    }    
    
}
