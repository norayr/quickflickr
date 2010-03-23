import Qt 4.6
BorderImage {

    signal clicked

    id: button
    property alias text: textElement.text
    width: 120;
    height: 45;
    source: "images/toolbutton.sci"
    smooth: true
    opacity: 0.7



    Text {
     id: textElement
     anchors.centerIn: parent
     font.pointSize: 20
     style: Text.Raised
     color: "white"
    }

    MouseArea {
        id: mouseRegion
        anchors.fill: parent
        onPressed: button.state = 'Pressed'
        onReleased: button.state = 'Default'
        onClicked: { button.clicked(); }
     }

    states:[
    State {
      name: "Pressed"
      when: mouseRegion.pressed == true
      PropertyChanges {
          target: textElement
          style: Text.Sunken
          color: "gray"
      }
    }
    ]


 }

