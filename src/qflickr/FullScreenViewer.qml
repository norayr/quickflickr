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
    /*
    PathView {     
        id:photoList       
        anchors.fill: parent
        //model: FavoritesModel{ id: favoritesModel }
        //delegate: FavoriteDelegate{}
        model: FullScreenModel{ id: fullScreenModel }
        delegate: FullScreenDelegate { id: fullScreenDelegate}
        
         path: Path{      
             
             startX: -(pathView.count*140)/2; startY: 200                                                                                     
             PathAttribute { name: "iconScale"; value: 0.6 }                             
             
             PathLine{ x: 100; y: 200 }
             PathAttribute { name: "iconScale"; value: 1.2 }            
             
             
             PathLine{ x: 300; y: 200 }
             PathAttribute { name: "iconScale"; value: 2.0 }            
             
             
             PathLine{ x: 500; y: 200 }
             PathAttribute { name: "iconScale"; value: 2.0 }                             
             
             PathLine{ x: 700; y: 200 }
             PathAttribute { name: "iconScale"; value: 1.2 }            
             
             
             PathLine{ x: 800 + (pathView.count*140)/2; y:200 }                                  
             PathAttribute { name: "iconScale"; value: 0.6 }
             
         }
         
        }
    */    
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
            hideNavigationBar: false
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

