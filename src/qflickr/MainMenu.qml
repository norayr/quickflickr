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
            flickrManager.getPhotostream(owner,1);
            flickrManager.getUserInfo( owner )
            photostream.userid = owner;            
            mainMenu.state = "photostream";
        }
    }


    PhotostreamView{
        id: photostream

        anchors.left: startupView.right
        anchors.top: startupView.top
        anchors.bottom:  startupView.bottom

        onThumbnailClicked: {
            //photoDetails.loading = true;
            flickrManager.getPhotoInfo(photoId);
            //flickrManager.getComments(photoId);
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

    ContactListView{
        id: contactsView
        width: settings.pageWidth
        height: settings.pageHeight

        anchors.left: photostream.right
        anchors.top: photostream.top
        anchors.bottom:  photostream.bottom
        onClicked: {
            photostream.userid = nsid;
            flickrManager.getPhotostream( nsid, 1 );
            flickrManager.getUserInfo( nsid )
            mainMenu.state = "photostream";
        }
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
                    photostream.userid = flickrManager.nsid();
                    flickrManager.getPhotostream( flickrManager.nsid(), 1 );
                    flickrManager.getUserInfo( flickrManager.nsid());
                }

                viewOffset = -settings.pageWidth;
                mainMenu.state = id;
            }
            else                        
            if ( id == "contacts"){
                flickrManager.getContacts();
                viewOffset = -settings.pageWidth * 2;
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
            PropertyChanges{
                target: bottomBar
                currentIndex: 0
            }
        },
        State {
            name: "photostream"

            PropertyChanges {
                target: startupView
                x: -settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 1
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
            PropertyChanges{
                target: bottomBar
                currentIndex: currentIndex
            }
        },
        State {
            name: "contacts"
            PropertyChanges {
                target: startupView
                x: -2*settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 2
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
}

