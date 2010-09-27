import Qt 4.7

Item{   
    id: navBar
    property bool showCloseButton: true
    property alias text: title.text    
    signal backClicked            
    
                
    Text{
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter        
        font.pixelSize: 22
        font.bold: true
        color: "white"
        smooth: true
        Behavior on text {
            PropertyAnimation { target: title; from: 0; to: 1; property: "scale"; duration: 300 }
        }
    }
    
    Image{
        id: background
        source: "qrc:///gfx/gfx/toolbar.png"    
        anchors.fill: parent
        smooth: true
        opacity: 0.3
    }
    
    // TODO: Create a reusable component for each button below
    Image{
        source: "qrc:///gfx/gfx/minimize.png"    
        anchors.left:  parent.left
        anchors.verticalCenter:  parent.verticalCenter   
        smooth: true
        opacity:  0.6
        scale: 0.7
        
        MouseArea{
            anchors.fill: parent
            onPressed: { parent.scale = 0.8; parent.opacity = 0.8; }
            onReleased: { parent.scale = 0.7; parent.opacity = 0.6; }
            onClicked: {  mainWindow.minimize(); }
        }
    }
    
    
    Flipable {                        
         id: buttonFlipable
         property int angle: 0
         width: closeButton.width
         anchors.right: parent.right             
         anchors.verticalCenter: parent.verticalCenter
         
         transform: Rotation {
             id: rotation
             origin.x: buttonFlipable.width/2 
             origin.y: buttonFlipable.height/2
             axis.x: 0 
             axis.y: 1 
             axis.z: 0     // rotate around y-axis
             angle: buttonFlipable.angle
         }

         front: Image{
             id: closeButton
             source: "qrc:///gfx/gfx/close.png"                 
             anchors.verticalCenter:  parent.verticalCenter 
             smooth: true
             opacity:  0.6
             scale: 0.7
             
             MouseArea{
                 anchors.fill: parent
                 onPressed: { parent.scale = 0.8; parent.opacity = 0.8; }
                 onReleased: { parent.scale = 0.7; parent.opacity = 0.6; }
                 onClicked: { mainWindow.close(); }
             }
         }
          
         
         back: Image{
             id: backButton
             source: "qrc:///gfx/gfx/back.png"                 
             anchors.verticalCenter:  parent.verticalCenter             
             smooth: true
             opacity:  0.6
             scale: 0.7
             
             MouseArea{
                 anchors.fill: parent
                 onPressed: { parent.scale = 0.8; parent.opacity = 0.8; }
                 onReleased: { parent.scale = 0.7; parent.opacity = 0.6; }
                 onClicked: { navBar.backClicked()}
             }
         }

         states:  State {
             name: "back"
             when: showCloseButton == false
             PropertyChanges { target: buttonFlipable; angle: -180; }             
         }

         transitions: Transition {
             NumberAnimation { properties: "angle"; duration: 400 }
         }

     }
    
   
    
    
    
}
