import Qt 4.6


ListView {
    id: contactList
    model: contactModel    
    spacing: 10
    width: 800
    height: 400
    focus: true
    cacheBuffer: 500 // Removes flickring on top and the bottom

    delegate: FlickrItemDelegate{ id: flickrItemDelegate }


}

