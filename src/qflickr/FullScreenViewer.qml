import Qt 4.7

Rectangle{    
    id: fullScreenViewer
    Image { source: "qrc:/images/quickflickr-bg.png"; anchors.fill: parent }    
    
    Connections{
        target: flickrManager
        onPhotostreamUpdated: {
            fullScreenModel.xml = xml;            
            fullScreenViewer.state = "Default"
        }
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
        opacity: 0
                         
    }
        
    Rectangle{
        id: loaderIndicator
        color: "black"        
        anchors.fill: parent
        visible: true
        border.color: "white"
        border.width: 3
        
        Row{
            id: indicatorRow            
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter        
            Loading{                     
                visible: loaderIndicator.visible
            }             
        }
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
    
    CommentsView{
        id: commentsView;
        x:0
        y:480
        onClose: {fullScreenViewer.state = 'Default'}        
        opacity: 0        
    }
    
    states:[
    State{
        name: "Default"  
        PropertyChanges {
            target: photoList
            opacity: 1
        }
        PropertyChanges {
            target: loaderIndicator
            opacity: 0
            visible: false
        }        
    },

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
        
        PropertyChanges {
            target: loaderIndicator
            opacity: 0
            visible: false
        }
    },
    State{
        name: "CommentsView"
        PropertyChanges { 
            target: commentsView;
            y: 0
            opacity: 1
        }

        PropertyChanges {
            target: photoList
            y:-480            
        }        
        
        PropertyChanges {
            target: loaderIndicator
            opacity: 0
            visible: false
        }
    }

    ]
    
    transitions: Transition {
             PropertyAnimation { properties: "x,y,opacity"; duration: 600 }
         }
}

