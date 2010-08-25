import Qt 4.7

Rectangle{    
    id: fullScreenViewer
    Image { source: "images/quickflickr-bg.png"; anchors.fill: parent }    
    
    Connections{
        target: flickrManager
        onPhotostreamUpdated: {fullScreenModel.xml = xml;}
    }
    
    ListView{    
        id: photoList
        model: FullScreenModel{ id: fullScreenModel }
        delegate: FullScreenDelegate { id: fullScreenDelegate}
        width: 800
        height: 480
        orientation: "Horizontal"
        snapMode: ListView.SnapOneItem
        spacing: 20
        focus: true
        cacheBuffer: 1600
                 

    }
            
    Text{
        anchors.fill: parent
        text: "Loading..."
        font.family: "Helvetica"
        font.pixelSize: 40
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        opacity: 1 - fullScreenModel.progress
    }


    // Create only one WebBrowser instance     
    WebBrowser{       
        id: webview        
        x:0
        y:480
        onClose: {fullScreenViewer.state = 'Default'; urlString=""}        
        showNavigationButtons: true
        opacity: 0
    }
    
    states:[
    State {
        name: "WebView"
        PropertyChanges {
            target: webview
            y:0     
            opacity: 1
        }
        
        PropertyChanges {
            target: photoList
            y:-480            
        }
        
    }        
    ]
    
    transitions: Transition {
             PropertyAnimation { properties: "x,y,opacity"; duration: 600 }
         }
}

