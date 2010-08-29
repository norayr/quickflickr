import Qt 4.7 

Image {
    id: recentActivityView
    width: 800
    height: 480
    source: "images/quickflickr-bg.png"; 
    state: 'Default'
        
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
        x:0
        y:10
        width: parent.width
        height: parent.height
        spacing: 10
        
        ScrollBar {            
            scrollArea: parent; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
        }
        
    }


    CommentsView{
        id: activityComments
        x: 800
        y: 105
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
