import Qt 4.6

Rectangle {
    id: fullScreenDelegate
    width: parent.width - 10
    height: parent.height -10
    x:5
    y:5
    border.color: "white"
    border.width: 1
    color: "black"


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
            width: //getWidth(thumbWidth,thumbHeight)
            height: 118
            x: (parent.width - width) / 2
            y: (parent.height - height ) / 2
        }
    }

    /*
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
        text: "by " + userName; font.family: "Helvetica"; font.pointSize: 20; color: "black"
        smooth: true
        anchors.top: title_.bottom
        anchors.left: thumbnail_.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }

    // Date taken section
    Text{
        id: dateTaken_
        text: "Date Taken: " + dateTaken; font.family: "Helvetica"; font.pointSize: 15; color: "black"
        anchors.top: userName_.bottom
        anchors.left: thumbnail_.right
        anchors.topMargin: 5
        anchors.leftMargin: 5
    }
    */
    // Handle mouse clicks
    MouseArea {
        anchors.fill: parent;
        onPressed: parent.color = "lightGray"
        onReleased: parent.color = "lightSteelBlue"

    }
}
