import Qt 4.7

Item{
    id: commentsView    
    width: settings.pageWidth


    Connections{
        target: flickrManager
        onCommentsUpdated: { commentsModel.xml = xml}
        // Make sure that adding a comment also updates this view
        onCommentAdded: { flickrManager.getComments(id) }
    }
    
    Component{
        id: commentDelegate
        Item{
            width: settings.pageWidth
            height:  childrenRect.height// commentText.paintedHeight
            opacity:  0
            Behavior on opacity { PropertyAnimation { duration: 400 } }

            Rectangle{
                id: commentBg
                color: "#00000000"
                border.color: "lightGray"
                border.width: 1                
                anchors.fill: parent

            }
            Image{
                id: buddyIcon
                source: "http://www.flickr.com/buddyicons/"+author+".jpg"
                anchors.left: commentBg.left
                anchors.leftMargin: settings.smallMargin
                anchors.top:  commentBg.top
                anchors.topMargin: settings.smallMargin
                width: 48
                height: 48
                onStatusChanged: status == Image.Ready?parent.opacity = 1:parent.opacity = 0;
            }
            Text{
                id: authorName
                color: "white"
                text: authorname
                anchors.left: buddyIcon.right
                anchors.leftMargin: settings.smallMargin
                anchors.top:  buddyIcon.top
                anchors.right:  commentBg.right
            }
            Text{
                id: commentText
                color: "white"
                text: comment
                wrapMode: Text.Wrap
                anchors.left: commentBg.left
                anchors.leftMargin:  settings.smallMargin
                anchors.top: buddyIcon.bottom
                anchors.topMargin: settings.smallMargin
                anchors.right: commentBg.right
                anchors.rightMargin: settings.smallMargin
            }
        }
    }

    CommentModel{
        id:commentsModel
    }

    ListView{
        id: commentsList
        delegate: commentDelegate
        model: commentsModel        
        anchors.fill: parent
        clip: true
        spacing: 1
        cacheBuffer: parent.height
        ScrollBar{
            scrollArea: parent
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
        }
    }                

    Loading{
        anchors.centerIn: commentsList
        visible: commentsModel.xml == ""
    }
}
