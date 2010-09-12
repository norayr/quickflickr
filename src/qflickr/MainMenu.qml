import Qt 4.7


Rectangle{
    id: mainMenu
    property alias authUrl: webauth.urlString
    
    anchors.fill: parent
    Image { source: "qrc:/images/quickflickr-bg.png"; anchors.fill: parent }    
    
    function contactsMode(){
        mainMenu.state = 'Contacts'; 
    }
    
    function favoritesMode(){
        mainMenu.state = 'Favorites';
        flickrManager.getFavorites();
    }
    
    function recentActivityMode(){        
        mainMenu.state = 'RecentActivity'
        flickrManager.getRecentActivity();
    }
    
    MenuButton{ id: contactsButton; 
                text: "Contacts";
                onClicked: parent.contactsMode();
                x:-750;y:140 }
    MenuButton{ id: myPhotoStreamButton; 
                text: "My Favorites"; 
                onClicked: parent.favoritesMode();
                anchors.left: contactsButton.right
                anchors.top: contactsButton.top
                anchors.leftMargin:50}
    MenuButton{ id: recentCommentsButton; 
                text: "Recent Activity"; 
                onClicked: parent.recentActivityMode(); 
                anchors.left: myPhotoStreamButton.right
                anchors.top: myPhotoStreamButton.top
                anchors.leftMargin:50}
    Image {
            id: quitButton
            source: "qrc:/images/quit.png"
            opacity: 1
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 10
            anchors.topMargin: 10
            
            MouseArea {
                anchors.fill: parent
                onClicked:{Qt.quit()}
            }
    }
    
    Image {
            id: minimizeButton
            source: "qrc:/images/minimize.png"
            opacity: 1
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 10
            anchors.topMargin: 10
            
            MouseArea {
                anchors.fill: parent
                onClicked:{ mainWindow.minimize(); }
            }
    }
    
    
    
    
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

    FavoritesView{
        id: favoritesView
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
            
            PropertyChanges{
                target: quitButton
                opacity: 1
            }
             
            PropertyChanges{
                target: minimizeButton
                opacity: 1
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
            
            PropertyChanges{
                target: quitButton
                opacity: 0
            }
            
            PropertyChanges{
                target: minimizeButton
                opacity: 0
            }
        },

        State{
            name: "Favorites"
            PropertyChanges{
                target: favoritesView
                x: 0
                y: 0
                opacity: 1
            }
            
            PropertyChanges{
                target: quitButton
                opacity: 0
            }
            
            PropertyChanges{
                target: minimizeButton
                opacity: 0
            }
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
            
            AnchorAnimation{
                
            }
        }
    }

    ]

}

