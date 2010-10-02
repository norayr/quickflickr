import Qt 4.7

// TODO: Add support for disabling and enabling the button
BorderImage {

    signal clicked

    id: button
    property alias text: textElement.text
    property alias source: icon.source
    width: 120;
    height: 45;
    source: "qrc:/images/toolbutton.sci"
    smooth: true
    opacity: 0.7



    Text {
     id: textElement
     anchors.centerIn: parent
     font.pixelSize: 20
     style: Text.Raised
     color: "white"
    }
    
    Image{
        id: icon
        smooth:  true
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        visible: source != ""
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
      PropertyChanges {
          target: icon          
          scale: 1.5
      }      
    }
    ]
    
    transitions: Transition{
        SmoothedAnimation{ duration: 500 }
    }


 }

