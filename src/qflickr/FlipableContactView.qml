import Qt 4.7


Item{    
    id: contactViewPage
    anchors.fill: parent
    clip: true        
    

    Flipable {                        
         id: mainFlipable
         property int angle: 0
         anchors.fill: parent         
         
         transform: Rotation {
             id: rotation
             origin.x: mainFlipable.width/2 
             origin.y: mainFlipable.height/2
             axis.x: 0 
             axis.y: 1 
             axis.z: 0     // rotate around y-axis
             angle: mainFlipable.angle
         }

         front:ContactList{
             id: contactList
             anchors.topMargin: 65
             anchors.top:  parent.top             
             anchors.left: parent.left
             anchors.right: parent.right
             anchors.bottom: parent.bottom
            }
          
         


         back: FullScreenViewer{
             id: fullScreenViewer
             anchors.fill: parent
         }

         states:  State {
             name: "back"
             PropertyChanges { target: mainFlipable; angle: -180; }   
             PropertyChanges { target: mainPage; hideNavigationBar: true; }
         }

         transitions: Transition {
             NumberAnimation { properties: "angle"; duration: 500 }
         }

     }
}






