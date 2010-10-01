import Qt 4.7


Item{
    id: mainMenu
    property alias authUrl: webauth.urlString    
    anchors.fill: parent
    
    Page{
        id: mainPage
        title: "QuickFlickr"
        anchors.fill: parent        
        onBackClicked:{ mainMenu.state = 'Menu'; }
    }
    
    
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
                x:-750;y:170 }
    MenuButton{ id: myPhotoStreamButton; 
                text: "Favorites"; 
                onClicked: parent.favoritesMode();
                anchors.left: contactsButton.right
                anchors.top: contactsButton.top
                anchors.leftMargin:50}
    MenuButton{ id: recentCommentsButton; 
                text: "Activity"; 
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
        anchors.topMargin: 65
    }

    FavoritesView{
        id: favoritesView
        opacity: 0
        anchors.topMargin: 65
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
                x: 149                                
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
            
            PropertyChanges {
                target: mainPage
                title: "Contact Uploads"
                showCloseButton: false                
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
            
            PropertyChanges {
                target: mainPage
                title: "Favorites"
                showCloseButton: false                
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
            PropertyChanges {
                target: mainPage
                title: "Recent Activity"
                showCloseButton: false                
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

