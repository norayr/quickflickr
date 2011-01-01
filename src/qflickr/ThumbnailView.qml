import Qt 4.7


Item{
    signal clicked( string photoId, url photoUrl )
    signal loadNextThumbnails()
    signal loadPreviousThumbnails()
    property alias model: grid.model
    property bool loading: false
    id: thumbnailView
    clip: true // clip left and right sides


    function loadMore(){
        if (grid.atYBeginning){
            loadPreviousThumbnails();
            console.log("prev page");
        }else
        if (grid.atYEnd){
            loadNextThumbnails();
            console.log("next page");
        }
    }


    GridView{
        id:             grid
        anchors.topMargin: settings.hugeMargin
        anchors.fill: parent
        cellHeight:     settings.pageWidth / 4
        cellWidth:      settings.pageWidth / 4
        delegate:       ThumbnailDelegate{onClicked: thumbnailView.clicked( photoId, photoUrl );}
        opacity: loading ?0.2:1
        onMovementEnded: loadMore();


        ScrollBar{
            scrollArea: parent
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 5
            anchors.bottomMargin: 5
            anchors.rightMargin: 5
        }
    }

    Loading{
        anchors.centerIn: grid
        id: topLoadingIndicator
        visible: parent.loading
    }
}
