import Qt 4.7


// List for showing uploads from contacts
ListView {
    id: listView
    model: contactModel
    spacing: 10
    anchors.fill: parent        
    clip: true
    cacheBuffer: 900 // Removes flickring on top and the bottom
    delegate: FlickrItemDelegate{ id: flickrItemDelegate }
}

