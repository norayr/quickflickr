import Qt 4.7

Item{
    id: photoDelegate
    height: settings.pageHeight
    width: settings.pageWidth
    state:  ""

    function addOrRemoveFavorite()
    {
        console.log( "AddOrRemoveFavorite: is fave:" + isfavorite == 0?"true":"false" +"," +id);

        if ( isfavorite ){
            flickrManager.addFavorite(id);
        }else{
            flickrManager.removeFavorite(id)
        }

        // Update current data from Flickr
        flickrManager.getPhotoInfo( id )
    }

    function addComment()
    {
        console.log("addCOmment");
        if ( photoDelegate.state != "addComment"){
            addCommentView.photoId = id;
            photoDelegate.state = "addComment";
        }else{
            photoDelegate.state = "";
        }
    }

    function showComments()
    {        
        if ( photoDelegate.state != "showComments"){
            flickrManager.getComments(id);
            photoDelegate.state = "showComments";
        }else{
            photoDelegate.state = "";
        }
    }

    function showInfo()
    {
        if ( photoDelegate.state != "showInfo"){
            photoDelegate.state = "showInfo";
        }else{
            photoDelegate.state = "";
        }
    }

    // Main image
    Image{
        id: photo        
        width: settings.pageWidth
        height:  settings.pageHeight
        fillMode: Image.PreserveAspectFit
        anchors.centerIn: parent
        smooth: true
        source: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_z.jpg"
        onSourceChanged: opacity = 0;
        onStatusChanged: { (status == Image.Ready)?opacity = 1:opacity = 0 }
        Behavior on opacity { PropertyAnimation { duration: 500 } }

        MouseArea{
            anchors.fill: parent
            onClicked: showInfo();
        }
    }

    Rectangle{
        id: detailsBg
        anchors.fill: parent
        anchors.topMargin: 1
        anchors.bottomMargin: 1
        color: "black"
        opacity: 0
    }

    // Title bar on top
    Item{
        id: titleBar
        height: 90
        anchors.bottom: photo.top
        anchors.left: photo.left
        anchors.right: photo.right

        // Placeholder for a graphics
        Rectangle{
            id: titleBarBg
            anchors.fill: parent
            anchors.rightMargin: 1
            color: "#00000000"
        }

        Text{
            id: titleText
            text: title
            color: "white"
            smooth: true
            anchors.top: titleBar.top
            anchors.left: titleBar.left
            anchors.right: titleBar.right
            anchors.leftMargin: settings.mediumMargin
            height: paintedHeight
            elide: Text.ElideRight
            font.pixelSize: settings.largeFontSize
        }

        Text{
            id: author
            text: "by " + username
            color: "white"
            smooth: true
            anchors.top: titleText.bottom
            anchors.left: titleText.left
            anchors.right: titleText.right
            anchors.rightMargin: settings.mediumMargin
            height: paintedHeight
            elide: Text.ElideRight
            font.pixelSize: settings.mediumFontSize
            horizontalAlignment: Text.AlignLeft
        }

        FlickrText{
            id: viewsText
            header: "Views"
            text: views
            anchors.top: author.bottom
            anchors.left: author.left
            anchors.topMargin: settings.mediumMargin
        }
        FlickrText{
            id: commentsText
            header: "Comments"
            text: comments
            anchors.top: viewsText.top
            anchors.left: viewsText.right
            anchors.leftMargin: settings.mediumMargin
        }
        FlickrText{
            id: dateText
            header: "date"
            text: datetaken
            anchors.top: viewsText.top
            anchors.left: commentsText.right
            anchors.leftMargin: settings.mediumMargin
        }
    }
    // End of the title bar


    // Description area in the middle
    Item{
        id: descriptionArea
        anchors.top: titleBar.bottom        
        anchors.bottom: bottomBar.top        
        anchors.left: photo.right

        // Placeholder for a graphics
        Rectangle{
            id: descriptionAreaBg
            anchors.fill: parent
            anchors.topMargin: 1
            anchors.bottomMargin: 1
            color: "black"
            opacity: 0.8
            visible: false
        }
        Flickable{
            id: flickableDescriptionText
            anchors.fill: descriptionAreaBg
            anchors.margins: settings.mediumMargin
            contentHeight: descriptionText.paintedHeight
            clip:  true
            Text{
                id: descriptionText
                text: description
                width: settings.pageWidth
                wrapMode: Text.Wrap
                smooth:  true
                font.pixelSize: settings.smallFontSize
                color: "white"
                opacity: 1
                clip: true
                textFormat: Text.RichText
            }

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
    }
    // End of the description area


    // Bottom bar at the bottom
    Item{
        id: bottomBar
        anchors.top: photoDelegate.bottom
        anchors.left: photoDelegate.left
        anchors.right: photoDelegate.right
        //anchors.topMargin: settings.smallMargin
        height: favoriteButton.height + 2*settings.mediumMargin

        // Placeholder for a graphics
        Rectangle{
            id: bottomBarBg
            anchors.fill: parent            
            color: "#00000000"            
        }

        Row{
            anchors.centerIn: bottomBarBg
            anchors.leftMargin: settings.mediumMargin
            anchors.rightMargin: settings.mediumMargin
            spacing:  (settings.pageWidth-settings.mediumMargin*2-favoriteButton.width*4) /3

            RadioIconButton{
                id: favoriteButton
                checkedIconSource: "qrc:///gfx/favorite-on.png"
                uncheckedIconSource: "qrc:///gfx/favorite-off.png"
                checked: isfavorite == "1"
                onClicked: addOrRemoveFavorite();
            }

            IconButton{
                id: descriptionButton
                enabledIconSource: "qrc:///gfx/description.png"
                //disabledIconSource: "qrc:///gfx/comments.png"
                enabled: true
                onClicked: showInfo();
            }

            IconButton{
                id: commentsButton
                enabledIconSource: "qrc:///gfx/comments-active.png"
                disabledIconSource: "qrc:///gfx/comments.png"
                enabled: comments != "0"
                onClicked: showComments();
            }
            IconButton{
                id: addCommentsButton
                enabledIconSource: "qrc:///gfx/comments-add.png"
                onClicked: addComment();
            }
        }
    }
    // End of the bottom bar


    // Comment field
    CommentsView{
        id: commentsView
        anchors.top: titleBar.bottom        
        anchors.bottom: bottomBar.top        
        anchors.left: photo.right        
    }
    // end of comment field

    // Add Comment Field
    AddCommentView{
        id: addCommentView
        anchors.top: titleBar.bottom
        anchors.bottom: bottomBar.top
        anchors.left: photo.right
        onCommentAdded: {showComments(); updateInfo.start()}

    }
    // end of add comment field

    Timer {
        id: updateInfo
         interval: 500;
         onTriggered: flickrManager.getPhotoInfo( id );
    }


    states: [
        State {
            name: "superState"
            AnchorChanges {
                target: titleBar
                anchors.bottom: undefined
                anchors.top: photo.top
            }
            AnchorChanges {
                target: bottomBar
                anchors.top: undefined
                anchors.bottom: photo.bottom
            }            
        },

        State {
            name: "showInfo"
            //extend: "superState"
            AnchorChanges {
                target: titleBar
                anchors.bottom: undefined
                anchors.top: photo.top
            }
            AnchorChanges {
                target: bottomBar
                anchors.top: undefined
                anchors.bottom: photo.bottom
            }            
            PropertyChanges{
                target: detailsBg
                opacity: 0.8
            }
            AnchorChanges{
                target: descriptionArea
                anchors.top: titleBar.bottom
                anchors.bottom: bottomBar.top
                anchors.left: photo.left
                anchors.right: photo.right
            }
        },
        State{
            name:  "showComments"
            //extend: "superState"
            AnchorChanges {
                target: titleBar
                anchors.bottom: undefined
                anchors.top: photo.top
            }
            AnchorChanges {
                target: bottomBar
                anchors.top: undefined
                anchors.bottom: photo.bottom
            }           
            PropertyChanges{
                target: detailsBg
                opacity: 0.8
            }
            AnchorChanges {
                target: descriptionArea
                anchors.left: photo.right
                anchors.right: undefined
            }
            AnchorChanges {
                target: commentsView
                anchors.left: photo.left
                anchors.right: photo.right
            }
        },
        State{
            name:  "addComment"
            //extend: "superState"
            AnchorChanges {
                target: titleBar
                anchors.bottom: undefined
                anchors.top: photo.top
            }
            AnchorChanges {
                target: bottomBar
                anchors.top: undefined
                anchors.bottom: photo.bottom
            }            
            PropertyChanges{
                target: detailsBg
                opacity: 0.8
            }
            AnchorChanges {
                target: descriptionArea
                anchors.left: photo.right
                anchors.right: undefined
            }
            AnchorChanges {
                target: addCommentView
                anchors.left: photo.left
                anchors.right: photo.right
            }
        }

    ]

    transitions: [
        Transition{
            AnchorAnimation{ duration: 500; easing.type: Easing.InOutExpo }
            PropertyAnimation{ duration: 500; properties: "opacity" }
        }

    ]

    onStateChanged: console.log("New State:" + state)

}
