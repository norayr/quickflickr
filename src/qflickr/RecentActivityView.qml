import Qt 4.7 

Image {
    id: recentActivityView
    anchors.fill: parent    
    state: 'Default'
        
    // Listen FlickrManager::recentActivityUpdated() signal and update
    // the xml to the model 
    Connections{
        target: flickrManager
        onRecentActivityUpdated: {
            recentActivityModel.xml = xml;
            loaderIndicator.visible = false;
        }
    }
    
    
    ListView{
        id: recentActivityList
        model: RecentActivityModel{id: recentActivityModel }
        delegate: RecentActivityDelegate{}        
        x:0
        y:10
        width: parent.width
        height: parent.height
        spacing: 10
        cacheBuffer: 480
        
        ScrollBar {            
            scrollArea: parent; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
        }
        
    }


    Loading{        
        id: loaderIndicator        
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }

        
    CommentsView{
        id: activityComments
        x: 800
        y: 115
        width: parent.width
        height: parent.height - activityComments.y - 10
    }

    states: [
        
        State {
            name: "Comments"
            PropertyChanges {
                target: activityComments
                x:0                
            }
            PropertyChanges {
                target: recentActivityList
                x:-800
                
            }
        }        
    ]
    
    transitions: [
        Transition {
            PropertyAnimation{
                properties: "x"
                easing.type: "OutCubic"
                duration: 500
            }
            AnchorAnimation {
    
            }   
        }
    ]
            
}
