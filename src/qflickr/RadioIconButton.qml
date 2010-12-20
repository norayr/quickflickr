import Qt 4.7

Item{
    id: iconRadioButton
    signal clicked(bool isChecked)
    property bool enabled: true
    property bool checked: false
    property string checkedIconSource
    property string uncheckedIconSource

    width:50
    height:50

    Image{
        id: icon
        smooth: true
        anchors.fill: parent
        source: iconRadioButton.checked? checkedIconSource: uncheckedIconSource
        sourceSize.width: 50
        sourceSize.height: 50
    }


    MouseArea{
        id: mouseArea
        anchors.fill: parent
        onPressed: { iconRadioButton.checked = !iconRadioButton.checked ;}
        onClicked: { if (iconRadioButton.enabled)iconRadioButton.clicked(checked);}
    }

    states: [
        State {
            name: "pressed"
            when:  iconRadioButton.enabled && mouseArea.pressed
            /*
            PropertyChanges {
                target: iconRadioButton
                checked: !checked
            }
            */
            PropertyChanges {
                target: icon
                scale: 0.9
            }
        }
        /*
        State {
            name: "pressed"
            when:  iconRadioButton.enabled && mouseArea.pressed
            PropertyChanges {
                target: icon
                scale: 0.9
            }
        }
        */

    ]

    transitions: Transition { PropertyAnimation{ duration: 100; easing.type: Easing.InElastic; properties: "scale" }}


}
