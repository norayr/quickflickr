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

    
    // Basic grid for thumbnails
    GridView{
        id:favoritesGrid
        width: parent.width
        height: favoritesModel.count / 10 * 80 
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10        

        model: FavoritesModel{id: favoritesModel}
        delegate: FavoriteDelegate{ }
        cellHeight: 80
        cellWidth: 80
        
        Connections{
            target: flickrManager
            onFavoritesUpdated: { favoritesModel.xml = xml; }        
            onFavoriteRemoved: flickrManager.getFavorites();
        }
        
        ScrollBar {            
            scrollArea: parent; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom }                        
        }
                
    }
    
    
    
    // Fullscree image for viewing a favorite. 
    FlickrImage{
        id: favoriteFullScreenImage
        property int maxHeight: parent.height
        property int maxWidth: parent.width
        
        function checkSize(){
            console.log(height + "," +  maxHeight )
            if ( height > maxHeight ){
                height = maxHeight-1;
            }
            if ( width > maxWidth ){
                width = maxWidth - 1;
            }
        }    
        
        
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        opacity: 0
        scale: 0
        fillMode: Image.PreserveAspectFit
        
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
        y: -50
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
                target: favoritesGrid
                opacity: 0.2                   
            }
            PropertyChanges {
                target: imageTitle
                opacity: 1      
                y: 10
                
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
        }
        
    ]
    
    transitions: [
        Transition {
            PropertyAnimation{ properties: "x,y,scale,opacity"; duration: 500; easing.type: Easing.InOutQuad}                                
        }
        
        

    ]        
}
