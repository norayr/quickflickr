import Qt 4.7

Item{
    id: favoritesView
    anchors.fill: parent
    state: "Default"
    property string photoId
    
    function showFullScreenFave( id, title, ownername, width, height, source ){        
        photoId = id;
        imageTitle.text =  title;
        author.text = "by " + ownername;
        favoriteFullScreenImage.width  = width;        
        favoriteFullScreenImage.height = height;
        favoriteFullScreenImage.checkSize(); // Do this before setting the source
        favoriteFullScreenImage.source = source;
        state = 'Details';
    }

    // This is needed here in order to get back if the image doesn't get loaded
    MouseArea{
        anchors.fill: parent                
        onPressAndHold: { mainMenu.state = 'Menu' }            
    }
        
    
    PathView {     
        id:pathView        
        anchors.fill: parent
        model: FavoritesModel{ id: favoritesModel }
        delegate: FavoriteDelegate{}
        
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

    Connections{
        target: flickrManager
        onFavoritesUpdated: { favoritesModel.xml = xml; loaderIndicator.visible = false;}        
        onFavoriteRemoved: flickrManager.getFavorites();
    }
    
    Loading{        
        id: loaderIndicator        
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    // Fullscreen image for viewing a favorite. 
    FlickrImage{
        id: favoriteFullScreenImage
        property int maxHeight: mainMenu.height - 6
        property int maxWidth: mainMenu.width - 6
        
        function checkSize(){                        
            if ( height >= maxHeight ){
                height = maxHeight-1;
            }
            if ( width >= maxWidth ){
                width = maxWidth - 1;
            }            
        }    
        
        
        // A little trick to make this image to use bit bigger area. There is a toolbar
        // and this widget's height is 480 - toolbar
        x: (maxWidth - width + 6) / 2
        y: (maxHeight- height + 6) / 2 - parent.y
        opacity: 0
        scale: 0        
        MouseArea{
            anchors.fill: parent
            onClicked: favoritesView.state = 'Default'
        }
        
    }
    
    Text {
        id: imageTitle        
        font.bold: true        
        color: "white"
        font.family: "Helvetica"
        font.pixelSize: 20
        smooth: true
        opacity: 0        
        x: 10
        y: -100
    }
    
    Text {
        id: author        
        font.bold: true        
        color: "white"
        font.family: "Helvetica"
        font.pixelSize: 20
        smooth: true
        opacity: 0        
        x: 10
        y: parent.height+50
    }
    
    Button{
        id: unfaveButton
        text: "Unfave"
        opacity: 0        
        x: parent.width - width - 10        
        y: parent.height+50
        
        onClicked:{            
            flickrManager.removeFavorite( parent.photoId )
            parent.state = 'Default'
        }
    }

    states: [        
        State {
            name: "Details"
            PropertyChanges {
                target: favoriteFullScreenImage
                scale: 1
                opacity: 1                
            }
            PropertyChanges {
                target: pathView
                opacity: 0.2                   
            }
            PropertyChanges {
                target: imageTitle
                opacity: 1      
                y: -parent.y + 10
                
            }   
            PropertyChanges {
                target: author
                opacity: 1      
                y: parent.height - (author.paintedHeight + 10)
                                
            }
            PropertyChanges {
                target: unfaveButton
                opacity: 1      
                y: parent.height - (unfaveButton.height + 10)
                                
            }  
            PropertyChanges { 
                target: mainPage; 
                hideNavigationBar: true; }
            
        }
        
    ]
    
    transitions: [
        Transition {
            PropertyAnimation{ properties: "x,y,scale,opacity"; duration: 500; easing.type: Easing.InOutQuad}                                
        }
                
    ]        
}
