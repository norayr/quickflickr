import Qt 4.7



// List for showing uploads from contacts
ListView {
    id: listView
    model: ContactListModel{id:contactListModel }
    spacing: 10
    anchors.fill: parent        
    clip: true
    cacheBuffer: 900 // Removes flickring on top and the bottom        
    delegate: ContactListDelegate{ id: contactListelegate }        
    
    Loader{
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter        
        visible: contactListModel.status != XmlListModel.Ready
    }
    
    ScrollBar {            
        scrollArea: parent; width: 8
        anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
    }
    
    
    Connections{
        target: flickrManager
        onContactsUploadsUpdated: {contactListModel.xml = xml;}
    }
        
}





