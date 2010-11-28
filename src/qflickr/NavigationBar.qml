import Qt 4.7

Item{
    id: navBar    
    property alias model: menu.model
    property int currentIndex: 0
    signal itemSelected(string id)

    height: settings.navigationBarHeight

    Rectangle{
        anchors.fill: parent
        opacity: 0.8
        gradient: Gradient {
             GradientStop { position: 0.0; color: "black" }
             GradientStop { position: 0.1; color: "darkGray" }
             GradientStop { position: 1.0; color: "black" }
           }
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

            MouseArea{
                anchors.fill: parent
                onClicked: navBar.itemSelected(strId)
            }
        }
    }



    // List view for containing the actual menu items
    ListView{
        id: menu
        //model: lmodel
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
                source: {if ( menu.currentIndex == index)"qrc:///gfx/gfx/indicator-selected.png"; else "qrc:///gfx/gfx/indicator-not-selected.png";}
                width:  15
                height: 15
                fillMode: Image.PreserveAspectFit
            }
        }
    }


    // TODO: Possibility to close and minimize the app
    // mainWindow.minimize()
    // mainWindow.close()

    
    
    
}
