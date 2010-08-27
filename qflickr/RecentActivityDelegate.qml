import Qt 4.7

Item {
   
    
    width: parent.width - 20
    height: thumb_s.height + activityDlgViews.height + activityDlgComments.height + activityDlgFaves.height + 50
    
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
        smooth: true
        anchors.left: thumb_s.right
        anchors.leftMargin: 10
        anchors.top: thumb_s.top                
        color: "white"
    }
    
    Text{    
        id: activityDlgOwner
        text: "by " + ownername 
        font.family: "Helvetica"; font.bold: true; font.pointSize: 20;
        smooth: true
        anchors.left: thumb_s.right
        anchors.leftMargin: 10
        anchors.top: activityDlgTitle.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    Text{    
        id: activityDlgViews
        text: "Views: " + views
        font.family: "Helvetica"; font.bold: true; font.pointSize: 16;
        smooth: true
        anchors.left: thumb_s.left        
        anchors.top: thumb_s.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    Text{    
        id: activityDlgComments
        text: "Comments: " + comments
        font.family: "Helvetica"; font.bold: true; font.pointSize: 16;
        smooth: true
        anchors.left: thumb_s.left
        anchors.top: activityDlgViews.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    Text{    
        id: activityDlgFaves
        text: "Faves: " + faves
        font.family: "Helvetica"; font.bold: true; font.pointSize: 16;
        smooth: true
        anchors.left: thumb_s.left        
        anchors.top: activityDlgComments.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    function check(x){
        if ( x == ""){
            return "";
        }else{
            return "- Comment: " + x + "<br>";
        }
    }

    
    Text{    
        id: activityDlgEventsC
        text:  check(event1) + check(event2) + check(event3) + check(event4) + check(event5) + check(event6)
        font.family: "Helvetica"; font.bold: true; font.pointSize: 16;
        smooth: true
        anchors.left:  activityDlgComments.right
        anchors.leftMargin: 10
        anchors.top: thumb_s.bottom                
        anchors.topMargin:10
        anchors.right: parent.right
        anchors.rightMargin: 10
        wrapMode: Text.WordWrap
        textFormat: Text.StyledText
        color: "white"
    }
    
    
    MouseArea{
        anchors.fill: parent
        onPressAndHold: {            
            mainMenu.state = 'Menu';  
        }
    }
}
