import Qt 4.7

Item{
    anchors.fill: parent
    
    Connections{
        target: flickrManager
        onCommentsUpdated: { commentsModel.xml = xml; }
        onCommentAdded: { flickrManager.getComments(photoId) }
    }
    
    ListView{
        id: commentsList
        delegate: CommentDelegate{ id: commentsDelegate }
        model: CommentModel{ id: commentsModel }
        anchors.fill: parent
        clip: true
        spacing: 10
        
        ScrollBar {            
            scrollArea: commentsList; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom; bottomMargin:5; topMargin:5 }                        
            
        }                
    }   
}    
