import Qt 4.7


Rectangle{
    id: mainMenu
    property alias authUrl: webauth.urlString
    
    anchors.fill: parent
    Image { source: "images/quickflickr-bg.png"; anchors.fill: parent }    
    
    
    function recentActivityMode(){
        console.log("Recent Activity Mode")
        mainMenu.state = 'RecentActivity'
        flickrManager.getRecentActivity();
    }
    
    MenuButton{ id: contactsButton; 
                text: "Contacts";
                onClicked: mainMenu.state = 'Contacts'; 
                x:-750;y:140 }
    MenuButton{ id: myPhotoStreamButton; 
                text: "My Photostream"; 
                onClicked: photostreamMode(); 
                anchors.left: contactsButton.right
                anchors.top: contactsButton.top
                anchors.leftMargin:50}
    MenuButton{ id: recentCommentsButton; 
                text: "Recent Activity"; 
                onClicked: parent.recentActivityMode(); 
                anchors.left: myPhotoStreamButton.right
                anchors.top: myPhotoStreamButton.top
                anchors.leftMargin:50}
    
    
    WebBrowser{       
        id: webauth        
        x:0
        y:480
        urlString: parent.authUrl
        onClose: {flickrManager.getToken();mainMenu.state = 'Menu';}
    }    
    

    // Contacts View
    FlipableContactView {
        id: contactsView                
        opacity: 0
    }

    
    RecentActivityView{
        id: recentActivityView
        opacity: 0
    }


    states: [
        State{
            name: "Authenticate"
            PropertyChanges{
                target: webauth
                y: 0
            }                    
            
        },

        State{
            name: "Menu"
            
            PropertyChanges{
                target: contactsView
                x: 800
                y: 0
                opacity: 0
            }
            
            PropertyChanges {
                target: contactsButton
                x: 50
                y: 140
                
            }
           
        },

        State{
            name: "Contacts"
            
            PropertyChanges{
                target: contactsView
                x: 0
                y: 0
                opacity: 1
            }
        },

        State{
            name: "MyPhotostream"
        },

        State{
            name: "RecentActivity"            
            
            PropertyChanges{
                target: recentActivityView
                x: 0
                y: 0
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition{

        ParallelAnimation{
            PropertyAnimation{                
                properties: "opacity"
                duration: 700
                easing.type: "OutCubic"
            }

            PropertyAnimation{                
                properties: "x,y,opacity"
                duration: 700
                easing.type: "OutCubic"
            }

        }
    }

    ]

}

