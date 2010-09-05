import Qt 4.7


Rectangle{
    id: mainView
    width:800; height: 480;    
    color: "black";        
    
    
    // Create a MainMenu
    MainMenu{ id: mainMenu }
    
    // Wait information from C++ side, should we authenticate first
    // or just show the normal menu
    Connections{
        target: flickrManager
        onProceed: {mainMenu.state = 'Menu'; flickrManager.getLatestContactUploads(); }
        onAuthenticationRequired: {mainMenu.authUrl = authUrl; mainMenu.state = 'Authenticate';}
    }
    
    
    
}
