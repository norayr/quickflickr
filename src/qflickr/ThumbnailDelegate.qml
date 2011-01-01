import Qt 4.7


Item{
    signal clicked( string photoId, url photoUrl )
    width: grid.cellWidth
    height: grid.cellHeight
    property url mediumSizeUrl: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg"
    FlickrImage{

        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        showBorder: true
        source:     url_s
        //source: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_t.jpg"
        borderWidth: 3
        width:      settings.gridCellWidth
        height:     settings.gridCellHeight
        fillMode: Image.PreserveAspectCrop
        clip:  true
        showLoader: false
        transform: Rotation{origin.x: width/2; origin.y: height/2; axis { x: 0; y: 0; z: 1 } angle: Math.random() * 10 * (index % 2?-1:1) }
        smooth: true
        onClicked: parent.clicked(id, mediumSizeUrl);
    }
}

