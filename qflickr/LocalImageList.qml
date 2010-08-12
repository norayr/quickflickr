import Qt 4.7

// List for showing uploads from contacts
ListView {
    
    model: localImageModel
    spacing: 10
    anchors.fill: parent        
    clip: true
    cacheBuffer: 900 // Removes flickring on top and the bottom
    delegate: LocalImageDelegate{ id: localImageDelegate }
}
