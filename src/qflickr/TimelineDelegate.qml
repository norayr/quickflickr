import Qt 4.7

Rectangle{
    id: polaroid
    transform: Rotation {
        origin.x: width / 2;
        origin.y: height / 2;
        axis { x: 0; y: 0; z: 1 }
        angle: if (index % 2 == 0) PathView.angle * -1; else PathView.angle;
    }
    scale: PathView.scale
    z: PathView.z
    width: 230
    height: 250
    color: "white"
    smooth:  true


    Image{
        id: image
        anchors.top:    parent.top
        anchors.topMargin: 10
        anchors.left:   parent.left
        anchors.leftMargin: 10
        anchors.right:  parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: author.paintedHeight


        source: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_z.jpg"
        smooth: true
        fillMode: Image.PreserveAspectCrop
        clip:  true

        MouseArea{
            anchors.fill: parent            
            onClicked: timelineView.thumbnailClicked(id, image.source);
        }

    }

    // Black rectangle for polaroid effect
    Rectangle{
        anchors.fill: image
        //color: "black"
        gradient: Gradient {
             GradientStop { position: 0.0; color: "black" }
             GradientStop { position: 0.5; color: "darkGray" }
             GradientStop { position: 1.0; color: "black" }
           }
        smooth:  true
        opacity:  1
        visible: opacity > 0
        NumberAnimation on opacity{
            to: 0
            duration: 1000
            running: image.status == Image.Ready
        }
    }

    Text{
        id: author
        anchors.top: image.bottom
        anchors.left: image.left
        anchors.right: image.right
        anchors.bottom: polaroid.bottom
        color: "black"
        text: "by " + username
        elide: Text.ElideRight
    }    
}
