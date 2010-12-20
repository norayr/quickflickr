import Qt 4.7


Item{
    id: iconButton
    signal clicked()        
    property bool enabled: true
    property string disabledIconSource
    property string enabledIconSource

    width:50
    height:50

    Image{
        id: icon
        smooth: true
        anchors.fill: parent
        source: iconButton.enabled? enabledIconSource: disabledIconSource
        sourceSize.width: 50
        sourceSize.height: 50
    }


    MouseArea{
        id: mouseArea
        anchors.fill: parent        
        onClicked: { if (iconButton.enabled)iconButton.clicked();}
    }

    states: [
        State {
            name: "pressed"
            when:  iconButton.enabled && mouseArea.pressed
            PropertyChanges {
                target: icon                
                scale: 0.9
            }
        }

    ]

    transitions: Transition { PropertyAnimation{ duration: 100; easing.type: Easing.InElastic; properties: "scale" }}
}
