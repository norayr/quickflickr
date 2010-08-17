import Qt 4.7

import "content"


    // List for showing uploads from contacts
    ListView {
        id: listView
        model: contactModel
        spacing: 10
        anchors.fill: parent        
        clip: true
        cacheBuffer: 900 // Removes flickring on top and the bottom
        delegate: FlickrItemDelegate{ id: flickrItemDelegate }
        
        ScrollBar {
            z: 2
            scrollArea: parent; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
        }
        
        // TODO: This doesn't work for some reason. The slot is called, but model doesn't work
        /*
        Connections{
            target: flickrManager
            onContactModelUpdated: { listView.model = model;}            
        }
        */
    }
    
    


