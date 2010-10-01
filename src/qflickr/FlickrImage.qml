import Qt 4.7

Item{
    property alias source: image.source
    property alias clip: image.clip
    property alias fillMode: image.fillMode
    property alias smooth: image.smooth
    property alias sourceSize: image.sourceSize    
    signal clicked
    signal pressAndHold
    
    
    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"
        border.width: 2
        border.color: "white"
        
        Image{
            id: image
            scale: 0.0
            anchors.fill: parent
            smooth: true
            anchors.topMargin: background.border.width
            anchors.bottomMargin: background.border.width
            anchors.leftMargin: background.border.width
            anchors.rightMargin: background.border.width
            
        }   
        
        Loading{            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            visible: image.status != Image.Ready            
        }
    }
    
    
    MouseArea{
        anchors.fill: parent
        onClicked: parent.clicked();     
        onPressAndHold: parent.pressAndHold();
    }
    
    states: [
        State {
            name: "Show"; 
            when: image.status == Image.Ready
            PropertyChanges { target: image; scale: 1 }
        }
    ]    
    
    transitions: [
        Transition {
            PropertyAnimation {
                properties: "scale"
                easing.type: "OutCubic"
                duration: 500
            }            
        }
    ]
}
