import Qt 4.7

Item {
   
    
    width: parent.width - 20
    height: 200
    x: 10   
    

    BorderImage{
        id: activityDelegateBg
        source: "images/toolbutton.sci"
        smooth: true
        opacity: 0.3
        anchors.fill: parent        
    }        
    
    
    Image{
        id: thumb_s
        source: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_s.jpg"
        anchors.left: activityDelegateBg.left
        anchors.top: activityDelegateBg.top
        anchors.topMargin:10
        anchors.leftMargin:10
        width: 75
        height: 75
    }

    Text{    
        id: activityDlgTitle
        text: title 
        font.family: "Helvetica"; font.bold: true; font.pointSize: 22;
        anchors.left: thumb_s.right
        anchors.leftMargin: 10
        anchors.top: thumb_s.top                
        color: "white"
    }
    
    Text{    
        id: activityDlgStatistics
        text: "by" + ownername 
        font.family: "Helvetica"; font.bold: true; font.pointSize: 22;
        anchors.left: thumb_s.right
        anchors.leftMargin: 10
        anchors.top: activityDlgTitle.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    MouseArea{
        anchors.fill: parent

        //onClicked: {
        //    mainFlipable.state = 'back';
        //    flickrManager.getPhotosOfContact(owner);            
        //}

        onPressAndHold: {            
            mainMenu.state = 'Menu';  
        }
    }
}
