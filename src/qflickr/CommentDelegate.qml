import Qt 4.7

// Bit crappy implementation for this delegate. Will be improved later.
Item{
    id: commentListDelegate
    width: commentsList.width
    height: getHeight(commentText.paintedHeight + commentAuthor.paintedHeight + commentDate.paintedHeight)
        
    
    function getHeight( textHeight ){
        if ( textHeight <= 48 ){
            return 48 + 20;
        }else{
            return textHeight + 40;
        }
    }
    
    BorderImage{
        id: background
        source: "qrc:/images/toolbutton.sci"
        smooth: true
        opacity: 0.3
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height
    }
    
    Text{
        id: commentAuthor
        text: "Comment by " + authorname
        smooth: true
        color: "white"
        width: background.width - buddyIcon.width - 10       
        anchors.leftMargin: 10
        anchors.rightMargin: 10                
        anchors.left: buddyIcon.right
        anchors.top: buddyIcon.top        
        font.pixelSize: 20
        font.family: "Helvetica"
        font.bold: true
        elide: Text.ElideRight
    }
    
    // TODO: Fix this to show correct date
    Text{
        id: commentDate
        text:  Qt.formatDate(datecreate,"ddd MMMM d yy")
        smooth: true
        color: "white"
        width: background.width - buddyIcon.width - 10       
        anchors.leftMargin: 10
        anchors.rightMargin: 10                
        anchors.left: buddyIcon.right
        anchors.top: commentAuthor.bottom
        font.pixelSize: 18
        font.family: "Helvetica"
        
    }
    
    Text{
        id: commentText
        text: comment
        smooth: true
        color: "white"
        width: background.width - buddyIcon.width - 10       
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10     
        anchors.left: buddyIcon.right
        anchors.top: commentDate.bottom       
        font.pixelSize: 20
        font.family: "Helvetica"
        wrapMode: Text.Wrap
        textFormat: Text.RichText
        
        onLinkActivated:{console.log("Link activated" + link); webview.urlString = link; fullScreenViewer.state = 'WebView'; }
    }
    
    FlickrImage{
        id: buddyIcon    
        anchors.top: background.top
        anchors.left: background.left
        anchors.topMargin: 10
        anchors.leftMargin: 10
        width: 48
        height: 48
        source: "http://www.flickr.com/buddyicons/"+author+".jpg"        
    }        
}
