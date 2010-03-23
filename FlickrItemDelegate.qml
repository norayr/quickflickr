import Qt 4.6
// Simple delegate which displays some common information about a
// single image from flickr. This delegate scales all the thumbnails
// to fixed width.
Rectangle{
    id: flickrItemDelegate
    width: contactList.width - 20
    height: 130
    radius: 5
    x: 10
    border.color: "black"
    border.width: 1
    color: "lightsteelblue"


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

        // Simple function for calculating the correct width. If the
        // widht is more than 250, the image will be forced to fit
        // in it, otherwise it just scales down the image maintaining
        // the aspect ratio.
        Script{
            function getWidth( w, h ){
                var width = w *(118/h);
                if ( width > 250 )
                    return 248;
                else
                    return width;
            }
        }

        // Actual thumbnail image
        Image{
            id: thumbImage
            source: url
            smooth: true
            width: getWidth(thumbWidth,thumbHeight)
            height: 118
            x: (parent.width - width) / 2
            y: (parent.height - height ) / 2
        }

        MouseArea{
            onClicked: thumbnail_.color = "red"
            anchors.fill:  parent
        }

    }

    // Title section
    Text{
        id: title_
        //elide: ElideLeft
        width: parent.width - thumbnail_.width - 10
        text: title; font.family: "Helvetica"; font.pointSize: 22; color: "red"
        anchors.top: parent.top
        anchors.left: thumbnail_.right
        anchors.leftMargin: 5
        anchors.topMargin: 10
    }

    // Username section
    Text{
        id: userName_
        text: qsTr("by ") + userName;
        font.family: "Helvetica";
        font.pointSize: 20;
        color: "black"
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
        color: "black"
        anchors.top: userName_.bottom
        anchors.left: thumbnail_.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

    Button{
        text: qsTr("Show more")
        x: 650
        y: 80
        onClicked: requestUserPhotos()
    }

    // Handle mouse clicks
    /*
    MouseArea {
        anchors.fill: parent;
        // TODO: Add here something to indicate the "press"
        //onPressed: parent.color = "lightGray"
        //onReleased: parent.color = "lightSteelBlue"
        onClicked: mainFlipable.state = (mainFlipable.state == 'back' ? '' : 'back')

    }
    */
}

