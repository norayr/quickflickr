import Qt 4.7


FlickrImage{
    id: favoriteDelegate
    x: 2.5
    y: 2.5
    width: 100
    height: 100
    source: "http://farm" + farm + ".static.flickr.com/" + server + "/" + id + "_" + secret + "_m.jpg"                
    state: 'Default'
    scale: PathView.iconScale
    fillMode: Image.PreserveAspectCrop
    clip: true
    z: scale == 2.0 ? 2: 1
    
    onClicked: {
        if ( favoritesView.state == 'Default' && scale == 2.0){  
            favoritesView.showFullScreenFave(id,  title, ownername, model.width, model.height, url );            
        }
    }
            
}
