import Qt 4.7


FlickrImage{
    id: favoriteDelegate
    x: 2.5
    y: 2.5
    width: 75
    height: 75
    source: "http://farm" + farm + ".static.flickr.com/" + server + "/" + id + "_" + secret + "_s.jpg"                
    state: 'Default'
    
    onClicked: {
        if ( favoritesView.state == 'Default'){  
            favoritesView.showFullScreenFave(id,  title, ownername, model.width, model.height, url );            
        }
    }
    
    onPressAndHold: {
        mainMenu.state = 'Menu'
    }
    
        
}
