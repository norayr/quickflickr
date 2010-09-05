import Qt 4.7

Item{
    id: commentsView
    property string photoId            
    width: 800
    height: 480        
    signal close
    
    
    
    
    MouseArea{
        anchors.fill: parent
        onPressAndHold: {console.log("Comments view close clicked"); commentsView.close()}
    }
    
    
    
    BorderImage {
        source: "qrc:/images/toolbutton.sci"
        smooth: true
        opacity: 0.3
        
    
        id: background
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 10        
        anchors.rightMargin: 10
        height: 100
    
    }
    
    Flickable {
        id: textField
   
        anchors.left: background.left
        anchors.right: addCommentButton.left
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        height: 100;
        anchors.top: parent.top
        anchors.topMargin: 10
        contentWidth: textEdit.paintedWidth
        contentHeight: textEdit.paintedHeight
        clip: true
   
        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }
   
       
            
        TextEdit {
            id:textEdit
            width: textField.width
            height: textField.height
            focus: true
            wrapMode: TextEdit.Wrap
            onCursorRectangleChanged: textField.ensureVisible(cursorRectangle)
            color: "white"
            font.pixelSize: 20
            font.family: "Helvetica"
        }
        
        ScrollBar {            
            scrollArea: textField; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom; bottomMargin:5; topMargin:5 }                        
            
        }
   
    }

    Button{ 
        id: addCommentButton
        text: "Add"        
        anchors.verticalCenter: textField.verticalCenter
        anchors.right:  background.right
        anchors.rightMargin: 10
        onClicked:{
            if ( textEdit.text != "" ){
                flickrManager.addComment(photoId, textEdit.text);
                textEdit.text = "";
                console.log("CommentAdded");
            }
        }
    }

    Connections{
        target: flickrManager
        onCommentsUpdated: { commentsModel.xml = xml; }
        onCommentAdded: { flickrManager.getComments(photoId) }
    }
    
    ListView{
        id: commentsList
        delegate: CommentDelegate{ id: commentsDelegate }
        model: CommentModel{ id: commentsModel }
        anchors.top: background.bottom
        anchors.left: background.left
        anchors.right: background.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        clip: true
        spacing: 10
        
        ScrollBar {            
            scrollArea: commentsList; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom; bottomMargin:5; topMargin:5 }                        
            
        }
        
        MouseArea{
            anchors.fill: parent
            onPressAndHold: fullScreenViewer.state = 'Default'
        }
    }                
            
}
