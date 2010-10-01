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
