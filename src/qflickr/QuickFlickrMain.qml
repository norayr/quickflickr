import Qt 4.7


Rectangle{
    id: mainView

    // Settigs object initialization. It holds all the application
    // level settings.
    Settings{ id: settings }

    width: settings.width
    height: settings.height
    color: "gray"

    // Create a MainMenu
    MainMenu{
        id: mainMenu
        anchors.fill: parent
    }
    
    // Wait information from C++ side, should we authenticate first
    // or just show the normal menu
    Connections{
        target: flickrManager
        onProceed: {mainMenu.state = 'Menu';
                    flickrManager.getLatestContactUploads();
                    }

        onAuthenticationRequired: {mainMenu.authUrl = authUrl;
                                   mainMenu.state = 'Authenticate';}
    }            
}
