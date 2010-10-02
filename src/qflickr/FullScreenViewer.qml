import Qt 4.7

Item{    
    id: fullScreenViewer    
    
    Connections{
        target: flickrManager
        onPhotostreamUpdated: {
            fullScreenModel.xml = xml;            
            fullScreenViewer.state = "Default"
        }
    }
    
    
    Rectangle{
        color:  "white"
        anchors.fill: parent
    
        ListView{    
            id: photoList
            model: FullScreenModel{ id: fullScreenModel }
            delegate: FullScreenDelegate { id: fullScreenDelegate}
            anchors.fill: parent
            orientation: "Horizontal"
            snapMode: ListView.SnapOneItem        
            focus: true
            cacheBuffer: 1600
            opacity: 0
                             
        }
    } 
    
    Image{
        source:  "qrc:///gfx/gfx/film_strip.png"
        id: loaderIndicator
        anchors.fill: parent
        visible: true
        
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
            y: 65
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
        
        PropertyChanges {
            target: mainPage
            hideNavigationBar: true
        }
        
    }

    ]
    
    transitions: Transition {
            ParallelAnimation{
                PropertyAnimation{ target: photoList; property: "opacity"; duration: 1000;}
                PropertyAnimation{ target: loaderIndicator; property: "opacity"; duration: 1500; }                
                PropertyAnimation { properties: "x,y"; duration: 600 }
            }
         }
         
}

