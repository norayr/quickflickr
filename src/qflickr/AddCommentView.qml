import Qt 4.7

Item{
    id: addCommentView
    // An id for photo to which comment will be added
    property string photoId
    signal commentAdded()
    onPhotoIdChanged: clear() // Clear the old crap if photo id changes
    width: settings.pageWidth

    function clear(){
        commentText.text = "";
    }

    function addComment( text)
    {
        if (photoId == ""){
            console.log("Can't add comment. Photo id is empty");
            return;
        }

        if (text == ""){
            console.log("Can't add comment. Comment string is empty");
            return;
        }

        flickrManager.addComment(photoId, text);
        addCommentView.clear();
        addCommentView.commentAdded();
    }

    Rectangle {
        id: addCommentBg
        color: "black"
        opacity: 0.8
        anchors.fill: parent
        visible: false
    }

    Text{
        id: addCommentTitle
        text: "Add Comment:"
        font.pixelSize: settings.mediumFontSize
        color: settings.fontColor
        anchors.top: addCommentBg.top
        anchors.topMargin: settings.mediumMargin
        anchors.left: addCommentBg.left
        anchors.right: addCommentBg.right
    }

    Rectangle{
        id: textEditBg
        //anchors.top: addCommentTitle.bottom
        anchors.left: addCommentBg.left
        anchors.right: addCommentBg.right
        //anchors.bottom: addCommentBg.bottom
        //anchors.topMargin: settings.largeMargin * 2
        anchors.leftMargin: settings.mediumMargin
        anchors.rightMargin: settings.mediumMargin
        //anchors.bottomMargin: settings.largeMargin * 2
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height / 2
        color:  "white"
        radius: 15
        smooth: true
        border.width: 1
        border.color: "blue"
        opacity: 0.5
    }
    TextEdit {
        id: commentText
        anchors.fill: textEditBg
        anchors.topMargin: settings.mediumMargin
        anchors.leftMargin: settings.mediumMargin
        anchors.rightMargin: settings.mediumMargin
        anchors.bottomMargin: settings.mediumMargin
        font.pointSize: settings.smallFontSize
        color: "black"
        //focus: true
        clip: true
    }

    Button{
        id: addCommentButton
        //anchors.top: textEditBg.bottom
        //anchors.topMargin: settings.largeMargin
        anchors.top: textEditBg.bottom
        anchors.topMargin: settings.largeMargin
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Add"
        onClicked: addComment(commentText.text);
    }

}
