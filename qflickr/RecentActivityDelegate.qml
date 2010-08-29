import Qt 4.7

Item {
   
    id: activityDelegate
    width: parent.width - 20
    //height: thumb_s.height + activityDlgViews.height + activityDlgComments.height + activityDlgFaves.height + 50
    height: thumb_s.height + 20
    x: 10   
    state: 'Default'

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
        text: "Views: " + views + " Comments: " + comments + " Favorites: " + faves
        font.family: "Helvetica"; font.bold: true; font.pointSize: 16;
        smooth: true
        anchors.left: thumb_s.right
        anchors.leftMargin: 10
        anchors.top: activityDlgOwner.bottom                
        anchors.topMargin:10
        color: "white"
    }
    
    function itemClicked(){        
        activityComments.photoId = id;        
        flickrManager.getComments(id);

        if( recentActivityView.state == 'Default'){        
            recentActivityView.state = 'Comments';
        }else{
            recentActivityView.state = 'Default';
        }
        
        if ( state == 'Default'){
            state = 'CommentView';
        }else{
            state = 'Default';              
        }
    }
    
    MouseArea{
        anchors.fill: parent
        onPressAndHold: {   
            if ( recentActivityView.state == 'Default'){
                mainMenu.state = 'Menu';  
                console.log("menu...");
            }else{
                recentActivityView.state = 'Default'    
                console.log("Default");
            }
        }
        
        onClicked:{
            itemClicked();    
        }
    }
    
    states:[
        State {
            name: "CommentView"            
            ParentChange { target: activityDelegate; x: 10; y: 10; parent: recentActivityView }            
        }                
    ]
    
    transitions: [
    /*     
    Transition {
        from: 'Default'; to: 'CommentView';
        ParentAnimation {        
            NumberAnimation { properties: "x,y"; duration: 500 }
        }
     },
    */ 
    Transition {      
        ParentAnimation {        
            NumberAnimation { properties: "x,y"; duration: 500 }
        }
     }
    ]

    
}
