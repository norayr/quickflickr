import Qt 4.7


Image{
    id: fullScreenDelegate
    width: 800
    height: 480    
    source:  "qrc:///gfx/gfx/film_strip.png"
    state:  "Default"
    property bool commentsOk: false
    
    // This is needed here in order to get back if the image doesn't get loaded
    MouseArea{
        anchors.fill: parent                
        onPressAndHold: {mainFlipable.state = 'front'; clearTimer.start()}            
    }
   
    // TODO: Remove this when real film strip gfx exists
    
    
    // Actual thumbnail image. The size of
    // image is kept quite small untill it will be loaded
    Image{
        id: thumbImage
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter                
        source: url
        smooth: true        
        fillMode: Image.PreserveAspectFit        
        
        height:320
        //onStatusChanged: {if(thumbImage.status == Image.Ready) fullScreenDelegate.state = 'ImageLoaded';}
        
        MouseArea{
            anchors.fill: parent        
            onClicked: {          
                
                if ( fullScreenDelegate.state == "Default"){
                    fullScreenDelegate.state = 'Details';                    
                }else{
                    fullScreenDelegate.state = "Default";
                    flipable.state = 'front';
                }
            }
            
            onPressAndHold: {mainFlipable.state = 'front'; clearTimer.start()}            
        }
    }
    
    Button {
        id: addCommentButton                        
        anchors.top:  parent.bottom
        anchors.left: commentButton.right
        anchors.leftMargin: 25
        opacity:  0
        width:  50
        height: 50
        source: "qrc:///gfx/gfx/add_comment.png"      
        onClicked:{ 
            parent.state = 'Comment';
        }
    }
    
    Button {
        id: commentButton                        
        anchors.top:  parent.bottom
        anchors.left: faveButton.right
        anchors.leftMargin: 25
        opacity:  0
        width:  50
        height: 50
        source: "qrc:///gfx/gfx/comment.png"      
        onClicked:{ 
            if ( !parent.commentsOk ){
                commentsView.photoId = id;
                flickrManager.getComments(id); 
                parent.commentsOk = true;
            }
            
            if ( flipable.state == "front" ){
                flipable.state = 'back'; 
            }else{
                flipable.state = 'front';
            }
            
            fullScreenDelegate.state = "Details";            
        }
    }
    
    
    Button {
        id: faveButton        
        anchors.top: commentButton.top        
        anchors.left: parent.left        
        opacity:  0
        width:  50
        height: 50
        source: "qrc:///gfx/gfx/favorite.png"        
        onClicked:{  flickrManager.addFavorite(id) }        
    }
    
    Flipable{
        id: flipable
        state: "front"
        property int angle: 0
        anchors.left: parent.right
        anchors.leftMargin: 10        
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.bottom: parent.bottom
        anchors.bottomMargin:  70
           
        
        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2 
            origin.y: flipable.height/2
            axis.x: 0 
            axis.y: 1 
            axis.z: 0     // rotate around y-axis
            angle: flipable.angle
        }
        
       
        front:FullScreenInfoField{
            id: infoField
            anchors.fill: parent
            title: model.title
            description: model.description
            tags: model.tags
            dateTaken: model.datetaken
            views: model.views                                
        }
        
        back: CommentList{
            id: commentList         
            anchors.fill: parent            
        }
        
        states:  State {
            name: "back"                       
            PropertyChanges { target: flipable; angle: -180; }             
        }

        transitions: Transition {
            NumberAnimation { properties: "angle"; duration: 400 }
        }
        

    }
    
    FullScreenCommentField{
        id: commentField
        photoId: id
        anchors.left: parent.right
        anchors.leftMargin: 10        
        anchors.rightMargin: 10
        anchors.top: parent.top
        anchors.topMargin: 130
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 120
        width: 200
        
        
    }
    
    Timer{
        id: clearTimer
        interval: 600; running: false; repeat: false
        onTriggered: { fullScreenModel.xml = ""; fullScreenViewer.state = ""; }
    }
    
    
    states: [
        State{
            name: "Details"
                        
            
            PropertyChanges{
                target: thumbImage
                width: 200   
                height: 320
                anchors.leftMargin: 10
                anchors.topMargin: 70
            }
            
            AnchorChanges{
                target:  thumbImage
                anchors.left: fullScreenDelegate.left                
                anchors.top:  parent.top                
                anchors.verticalCenter: undefined
                anchors.horizontalCenter: undefined
            }
            
            AnchorChanges {                
                target: flipable
                anchors.left: thumbImage.right                
                anchors.right: parent.right                
                anchors.top: parent.top                
                anchors.bottom: parent.bottom
            }
            
            AnchorChanges {
                target:  faveButton
                anchors.left: thumbImage.left                                                         
                anchors.bottom: parent.bottom               
            }
            
            AnchorChanges {
                target:  commentButton                
                anchors.top: undefined                
                anchors.bottom: parent.bottom               
            }
            AnchorChanges {
                target:  addCommentButton                
                anchors.top: undefined                
                anchors.bottom: parent.bottom               
            }
            
            PropertyChanges{
                target: addCommentButton
                opacity: 1
                anchors.bottomMargin: 75
            }
            PropertyChanges{
                target: commentButton
                opacity: 1
                anchors.bottomMargin: 75
            }
            
            PropertyChanges{
                target: faveButton
                opacity: 1
                anchors.bottomMargin: 75
            }
            
            PropertyChanges {                
                target: flipable
                opacity: 1
                scale: 1
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 70
            }
        },
        State{
            name: "Comment"
            AnchorChanges{
                target:  flipable
                anchors.left: parent.right                
                anchors.top: parent.top                
                anchors.bottom: parent.bottom                                
            }
            
            AnchorChanges {                
                target: commentField
                anchors.left: thumbImage.right                
                anchors.right: parent.right                
                anchors.top: parent.top                
                anchors.bottom: parent.bottom
            }
            
            PropertyChanges{
                target: thumbImage
                width: 200   
                height: 320
                anchors.leftMargin: 10
                anchors.topMargin: 70
            }
            
            AnchorChanges{
                target:  thumbImage
                anchors.left: fullScreenDelegate.left                
                anchors.top:  parent.top                
                anchors.verticalCenter: undefined
                anchors.horizontalCenter: undefined
            }
            
            
            AnchorChanges {
                target:  faveButton
                anchors.left: thumbImage.left                                                         
                anchors.bottom: parent.bottom               
            }
            
            AnchorChanges {
                target:  commentButton                
                anchors.top: undefined                
                anchors.bottom: parent.bottom               
            }
            AnchorChanges {
                target:  addCommentButton                
                anchors.top: undefined                
                anchors.bottom: parent.bottom               
            }
            
            PropertyChanges{
                target: addCommentButton
                opacity: 1
                anchors.bottomMargin: 75
            }
            PropertyChanges{
                target: commentButton
                opacity: 1
                anchors.bottomMargin: 75
            }
            
            PropertyChanges{
                target: faveButton
                opacity: 1
                anchors.bottomMargin: 75
            }
                        
        }
        
    ]

    transitions: [
        Transition {
        
            PropertyAnimation{  properties: "width,opacity";  duration: 500; easing.type: Easing.OutQuad }                    
            AnchorAnimation{ duration: 500;  easing.type: Easing.OutQuad }
        
        }    
    ]
                
}

