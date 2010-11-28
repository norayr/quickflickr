import Qt 4.7


Item{
    id: mainMenu

    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    property alias authUrl: webauth.urlString
    property int viewOffset: 0

    // The first, startup view. Just position it in relative to x, y.
    // The rest of the views are anchored relative to each others.
    Timelineview{
        id: startupView
        x: 0
        y: 0
        onThumbnailClicked: {
            photoDetails.source = url_m;
            mainMenu.state = "details"
        }
    }


    PhotostreamView{
        id: photostream

        anchors.left: startupView.right
        anchors.top: startupView.top
        anchors.bottom:  startupView.bottom

        onThumbnailClicked: {
            photoDetails.source = url_m;
            mainMenu.state = "details"
        }

    }

    PhotoDetailsView{
        id: photoDetails
        anchors.top: bottomBar.bottom
        //anchors.topMargin: settings.navigationBarHeight
        anchors.left: bottomBar.left
        anchors.right: bottomBar.right

        height: settings.pageHeight
        opacity:  0
    }

    Rectangle{
        id: contactsView
        width: settings.pageWidth
        height: settings.pageHeight

        anchors.left: photostream.right
        anchors.top: photostream.top
        anchors.bottom:  photostream.bottom
        color: "yellow"
    }



    // Model for a menu
    ListModel{
        id: lmodel
        ListElement {
             name: "Recent Uploads"
             strId: "startup"
         }
         ListElement {
             name: "Photostream"
             strId: "photostream"
         }
         ListElement {
             name: "Contacts"
             strId: "contacts"
         }
         ListElement {
             name: "Minimize"
             strId: "minimize"
         }
         ListElement {
             name: "Exit"
             strId: "exit"
         }
    }

    // Navigatiobar at the bottom of the page.
    NavigationBar{
        id: bottomBar;
        model:  lmodel
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        onItemSelected: {
            if ( id == "startup"){
                viewOffset = 0;
                mainMenu.state = id;
            }else
            if ( id == "photostream"){
                if ( mainMenu.state != "details"){
                    flickrManager.getPhotostream( flickrManager.nsid() );
                    flickrManager.getUserInfo( flickrManager.nsid());
                }
                viewOffset = -480;
                mainMenu.state = id;
            }
            else                        
            if ( id == "contacts"){
                viewOffset = -480 * 2;
                mainMenu.state = id;
            }
            else
            if ( id == "minimize" ){
                mainWindow.minimize();
            }
            else
            if ( id == "exit" ){
                mainWindow.close();
            }

        }
    }


    states:[
        State{
            name: "startup"

            PropertyChanges {
                target: startupView
                x: 0
                y: 0
            }            

        },

        State {
            name: "photostream"

            PropertyChanges {
                target: startupView
                x: -settings.pageWidth
                y: 0
            }


        },

        State {
            name: "details"
            AnchorChanges{
                target: photoDetails
                anchors.top: mainMenu.top
                anchors.left: bottomBar.left
                anchors.right: bottomBar.right
            }
            PropertyChanges{
                target: photoDetails
                opacity: 1
            }
            PropertyChanges {
                target: startupView
                y: -settings.pageHeight - settings.navigationBarHeight
                x: viewOffset
            }

        },

        State {
            name: "contacts"
            PropertyChanges {
                target: startupView
                x: -2*settings.pageWidth
                y: 0
            }
        },
        State{
            name: "Authenticate"
            PropertyChanges{
                target: webauth
                y: 0
            }

        }
    ]
    
    transitions: [
        Transition{

            ParallelAnimation{

                AnchorAnimation{}
                SequentialAnimation{

                PropertyAnimation{
                    properties: "y"
                    duration: 700
                    easing.type: "OutCubic"
                }

                PropertyAnimation{
                    properties: "x"
                    duration: 700
                    easing.type: "OutCubic"
                }
                PropertyAnimation{
                    properties: "opacity"
                    duration: 700
                    easing.type: "OutCubic"
                }
                }
            }
        }

    ]

    WebBrowser{
        id: webauth
        x:0
        y:parent.height
        urlString: parent.authUrl
        onClose: {flickrManager.getToken();mainMenu.state = 'Menu';}
    }

    /*
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
    */

}

