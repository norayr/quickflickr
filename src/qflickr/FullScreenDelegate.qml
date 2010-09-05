import Qt 4.7
//import "content"

Rectangle {
    id: fullScreenDelegate
    width: 796
    height: 476
    y: 0
    border.color: "white"
    border.width: 3
    color: "black"
    
   
   
    // Actual thumbnail image. The size of
    // image is kept quite small untill it will be loaded
    Image{
        id: thumbImage
        source: url
        smooth: true
        height: 0
        opacity: 0
        fillMode: Image.PreserveAspectFit
        x: (fullScreenDelegate.width) / 2
        y: (fullScreenDelegate.height) / 2
        sourceSize.width:800
        sourceSize.height:480
        onStatusChanged: {if(thumbImage.status == Image.Ready) fullScreenDelegate.state = 'ImageLoaded';}
        
        MouseArea{
            anchors.fill: parent        
            onClicked: {                
                if ( fullScreenDelegate.state == "ImageLoaded"){
                    fullScreenDelegate.state = 'Details';
                }else{
                    fullScreenDelegate.state = 'ImageLoaded';
                }
            }
            
            onPressAndHold: {mainFlipable.state = 'front'; clearTimer.start()}
            
        }
    }
    
    Timer{
        id: clearTimer
        interval: 600; running: false; repeat: false
        onTriggered: fullScreenModel.xml = ""
    }
    
    
    Text{
        id:progressText
        text: "Loading... " + Math.floor(thumbImage.progress*100) +"%"
        font.family: "Helvetica"
        font.pointSize: 40
        color: "white"
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 1 - thumbImage.progress
    }


    // Title section
    Text{
        id: title_
        elide: Text.ElideRight
        width: fullScreenDelegate.width - 20
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        text: title
        font.family: "Helvetica"
        font.pointSize: 22
        smooth: true
        color: "white"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: description_.left
        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.rightMargin: 5
        opacity: 0

    }

    // Description field
    BorderImage{
        id: description_
        source: "qrc:/images/toolbutton.sci"
        smooth: true
        opacity: 0        
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom:parent.bottom
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 60
        anchors.left: parent.horizontalCenter
        

        Flickable{
            id: flickable
            flickableDirection: Flickable.VerticalFlick            
            anchors.fill: description_
            anchors.topMargin: 2            
            contentHeight: descriptionTitle.height + descriptionText.height + 30                        
            clip: true
            
            
            Text{
                id: descriptionTitle
                text: "Description:"
                font.family: "Helvetica"
                font.pointSize: 22
                color: "white"
                smooth: true
                
                anchors.top: description.top                
                anchors.left: parent.left
                anchors.topMargin: 20
                anchors.leftMargin: 10
                x:10
                
            }
    
            Text{
                id: descriptionText
                text: description
                font.family: "Helvetica"
                font.pointSize: 15            
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                clip: true
                color: "white"
                smooth: true
                width: description_.width - 5
                anchors.top: descriptionTitle.bottom
                anchors.left: descriptionTitle.left
                anchors.right: parent.right                
                anchors.rightMargin: 5
                anchors.topMargin: 30
                textFormat: Text.RichText
                
                onLinkActivated:{webview.urlString = link; fullScreenViewer.state = 'WebView'; }
            }  
            
            ScrollBar {            
                scrollArea: flickable; width: 8
                anchors { right: parent.right; top: parent.top; bottom: parent.bottom; bottomMargin:5; topMargin:5 }                        
                
            }
        }                
                
    }

    Text {
        id: views_
        text: "Views: " + views
        smooth: true
        font.family: "Helvetica"; font.pointSize: 15; color: "white"
        anchors.top: thumbImage.bottom
        anchors.left: fullScreenDelegate.left
        anchors.right: description_.left
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        opacity:0

    }


    // Tags field. NOTE if there are "too many" tags
    // this widgets just clips stuff away.
    Item {
        id: tags_
        anchors.top: views_.bottom
        anchors.left: fullScreenDelegate.left
        anchors.right: description_.left
        anchors.bottom: description_.bottom
        anchors.topMargin: 5
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        opacity:0

        Text{
            id: tagsTitle
            text: "Tags:"
            font.family: "Helvetica"; font.bold: true; font.pointSize: 15; color: "white"
            anchors.top: parent.top
            anchors.left: parent.left
        }

        Text{
            id: tagsField
            text: tags
            clip: true
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            smooth: true
            font.family: "Helvetica"; font.pointSize: 15; color: "white"
            anchors.top: tagsTitle.bottom
            anchors.left: tagsTitle.left
            anchors.right: parent.right
            //anchors.bottom: fullScreenDelegate.bottom
            anchors.topMargin: 5
        }
    }


    
    
    Button {
        id: backButton
        text: "Add Fave!"
        anchors.top: description_.bottom
        anchors.right: description_.right
        anchors.topMargin: 10
        opacity: 0
        onClicked:{  flickrManager.addFavorite(id) }
        z: 5
    }
    
    Button {
        id: commentButton
        text: "Comments"
        anchors.top: description_.bottom
        anchors.right: backButton.left
        anchors.topMargin: 10
        anchors.rightMargin: 15
        opacity: 0
        onClicked:{ 
            commentsView.photoId = id;
            flickrManager.getComments(id); 
            fullScreenViewer.state = 'CommentsView' 
        }
        z: 5
    }

    Button {
        id: flickrButton
        text: "Go Flickr"
        anchors.top: description_.bottom
        anchors.right: commentButton.left
        anchors.topMargin: 10
        opacity: 0
        anchors.rightMargin: 15
        onClicked: { webview.urlString = "http://www.flickr.com/photos/"+owner+"/"+id; fullScreenViewer.state = 'WebView';}
        z: 5
    }
   
    states:[
    State{
        name: "Details"
        PropertyChanges{
            target: thumbImage
            height: 250
            width: 250       
            opacity: 1
            anchors.leftMargin: 10
            anchors.topMargin: 10
        }
        
        AnchorChanges{
            target: thumbImage
            anchors.left: fullScreenDelegate.left
            anchors.top: title_.bottom
        }

        PropertyChanges{
            target: title_
            opacity: 1
        }

        PropertyChanges{
            target: description_
            opacity: 0.8
        }

        PropertyChanges{
            target: backButton
            opacity: 1
        }
        
        PropertyChanges {
            target: commentButton
            opacity: 1            
        }
        
        PropertyChanges {
            target: flickrButton
            opacity: 1            
        }
        
        PropertyChanges{
            target: views_
            opacity: 1
        }
        PropertyChanges{
            target: tags_
            opacity: 1
        }
        },

    State{
        name: 'ImageLoaded';
        PropertyChanges{
            target: thumbImage
            opacity: 1
            width: 780
            height: 470
            x: (fullScreenDelegate.width - width) / 2
            y: (fullScreenDelegate.height - height) / 2
        }        
        
        AnchorChanges{
            target: description_
            anchors.left: fullScreenDelegate.right
        }

        AnchorChanges{
            target: backButton
            anchors.top: fullScreenDelegate.bottom
        }

        AnchorChanges{
            target: commentButton
            anchors.top: fullScreenDelegate.bottom
        }
        AnchorChanges{
            target: flickrButton
            anchors.top: fullScreenDelegate.bottom
        }
        }

    ]


    transitions:[ Transition{
        PropertyAnimation {
            properties: "opacity,height,width,x,y"
            easing.type: "OutCubic"
            duration: 500
        }

        AnchorAnimation {

        }
        }]    
}
