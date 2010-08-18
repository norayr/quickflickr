import Qt 4.7
// Simple delegate which displays some common information about a
// single image from flickr. This delegate scales all the thumbnails
// to fixed width.
Item{    
    width: contactList.width - 20
    height: 130
    x: 10    
    state: "Default"    

    BorderImage{
        source: "images/toolbutton.sci"
        smooth: true
        opacity: 0.5
        anchors.fill: parent
    }

    MouseArea{
        anchors.fill: parent

        onClicked: {
            mainFlipable.state = 'back';
            flickrManager.getPhotosOfContact(owner);            
        }

        onPressAndHold: {            
            mainMenu.state = 'Menu';  
        }
    }


    // Container for an image so that we can center
    // all the images and make texts align perfectly
    Rectangle{
        id: thumbnail_
        width: 250
        height: 120
        color: "black"
        border.width: 1
        border.color: "white"
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 5
        anchors.leftMargin: 10

        
        
    
        // Actual thumbnail image
        Image{            
            id: thumbImage
            source: url
            smooth: true
            fillMode: Image.PreserveAspectFit
            width: 250
            height: 118
            x: (parent.width - width) / 2
            y: (parent.height - height ) / 2            
        }

        Button{
            id: button_
            text: qsTr("Show more")
            anchors.right: thumbnail_.right
            anchors.bottom: thumbnail_.bottom
            anchors.rightMargin: 10
            anchors.bottomMargin: 10
            onClicked: {mainFlipable.state = 'back'; flickrManager.getPhotosOfContact(owner); }
            opacity: 0
            z: 3
        }

     
    }


    // Title section
    Text{
        id: title_
        elide: Text.ElideRight
        width: parent.width - thumbnail_.width - 10
        text: title; font.family: "Helvetica"; font.bold: true; font.pointSize: 22; color: "white"
        anchors.top: parent.top
        anchors.left: thumbnail_.right
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.topMargin: 10
        anchors.rightMargin: 10
    }

    // Username section
    Text{
        id: userName_
        elide: Text.ElideRight
        width: parent.width - thumbnail_.width - 10
        text: qsTr("by ") + userName;
        font.family: "Helvetica";
        font.pointSize: 20;
        color: "white"
        smooth: true
        anchors.top: title_.bottom
        anchors.left: thumbnail_.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

    // Date taken section
    Text{
        id: dateTaken_
        text: qsTr("Date Taken: ") + dateTaken;
        font.family: "Helvetica";
        font.pointSize: 15;
        color: "white"
        anchors.top: userName_.bottom
        anchors.left: thumbnail_.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

}








