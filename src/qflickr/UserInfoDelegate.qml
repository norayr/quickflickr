import Qt 4.7

Rectangle{
    anchors.fill: parent
    opacity: 0.8
    gradient: Gradient {
         GradientStop { position: 0.0; color: "black" }
         GradientStop { position: 0.1; color: "darkGray" }
         GradientStop { position: 1.0; color: "black" }
    }


    Image{
        id: buddyIcon
        source: "http://farm"+iconfarm+".static.flickr.com/"+iconserver+"/buddyicons/"+nsid+".jpg"
        width: 48
        height: 48
        anchors.top:  parent.top
        anchors.topMargin: settings.largeMargin
        anchors.left: parent.left
        anchors.leftMargin: settings.largeMargin
    }
    Text{
        id: userName
        text: username
        color: "white"
        font.pixelSize: settings.largeFontSize
        verticalAlignment: Text.AlignTop
        smooth: true
        anchors.top: buddyIcon.top
        anchors.left: buddyIcon.right
        anchors.leftMargin: settings.largeMargin * 2
        anchors.right: parent.right
    }
    Text{
        id: statistics
        color: "white"
        font.pixelSize: settings.smallFontSize
        smooth: true
        text: "Views: " + views + " "+"Photos: " + count// +" "+"Pro:" + ispro == 0?"No":"Yes"
        anchors.top:  userName.bottom
        anchors.topMargin: settings.mediumMargin
        anchors.left: userName.left
        anchors.right: userName.right
        anchors.bottom: buddyIcon.bottom
    }
    Text{
        id: dateTaken
        color: "white"
        font.pixelSize: settings.smallFontSize
        smooth: true
        text: "First upload: " + firstdatetaken
        anchors.top:  buddyIcon.bottom
        anchors.topMargin: settings.mediumMargin
        anchors.left: buddyIcon.left
        anchors.right: userName.right
    }
    Text{
        id: location
        color: "white"
        font.pixelSize: settings.smallFontSize
        smooth: true
        text: "Location: " + geolocation
        anchors.top:  dateTaken.bottom
        anchors.topMargin: settings.mediumMargin
        anchors.left: dateTaken.left
        anchors.right: dateTaken.right
    }
}
