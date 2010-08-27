import Qt 4.7 

Image {
    id: recentActivityView
    width: 800
    height: 480
    source: "images/quickflickr-bg.png"; 
        
    // Listen FlickrManager::recentActivityUpdated() signal and update
    // the xml to the model 
    Connections{
        target: flickrManager
        onRecentActivityUpdated: {recentActivityModel.xml = xml;}
    }
    
    
    ListView{
        id: recentActivityList
        model: RecentActivityModel{id: recentActivityModel }
        delegate: RecentActivityDelegate{}
        anchors.fill: parent
        spacing: 10
        
        ScrollBar {            
            scrollArea: parent; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
        }
        
    }

    /*
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
    */
}
