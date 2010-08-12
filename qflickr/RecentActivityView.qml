import Qt 4.7 

Rectangle {
    id: recentActivityView
    width: 800
    height: 480
    
    MouseArea{
        anchors.fill: parent

        //onClicked: {
        //    mainFlipable.state = 'back';
        //    flickrManager.getPhotosOfContact(owner);            
        //}

        onPressAndHold: {            
            mainMenu.state = 'Menu';  
        }
    }
}
