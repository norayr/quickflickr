import Qt 4.7

Rectangle {
    property string authenticationUrl
    property bool webBrowserOpened: false
    width: settings.width
    height: settings.height
    color: "black"

    function checkOnClicked()
    {
        if (!webBrowserOpened){
            //Qt.openUrlExternally(authenticationUrl);
            //webAuth.urlString = authenticationUrl;
            webauth.opacity = 1;
            webBrowserOpened = true;
        }else {
            flickrManager.getToken();
            mainMenu.state = 'Menu';
            webBrowserOpened = false;
        }
    }

    Text{
        id: authTextTitle
        color:  "white"
        text: "Authenticate with Flickr"
        font.pixelSize: settings.largeFontSize
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: settings.hugeMargin
    }
    Text{
        id: instructionsText
        anchors.top: authTextTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: settings.hugeMargin
        width: parent.width
        wrapMode: Text.Wrap
        font.pixelSize: settings.smallFontSize
        color:  "white"
        text: "Tap the \"Go\" button for authenticating QuickFlickr with Flickr. " +
              "Follow the instructions on a Web browser. After you have successfully allowed QuickFlickr to " +
              "use your Flickr account, close the Web browser and tap the \"Continue\" button from this page.\n\n" +
              "You can log out from \"Settings & About\" page and login as a different user later."
    }

    Row{
        anchors.top: instructionsText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: settings.hugeMargin
        spacing: settings.largeMargin
        Button{
            id: authenticateButton
            text: { if (!webBrowserOpened) return "Go"; else return "Continue"; }
            onClicked: checkOnClicked();
        }
        Button{
            id: cancelButton
            text: "Close"
            onClicked: mainWindow.close();
        }
    }

    Image{
        source: "qrc:/gfx/d-pointer-logo.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }


    WebBrowser{
        id: webauth
        x:0
        y: 0//settings.height
        urlString: authenticationUrl//parent.authUrl
        onClose: opacity = 0//{flickrManager.getToken();mainMenu.state = 'Menu';}
        opacity: 0
    }

}
