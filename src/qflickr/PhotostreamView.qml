import Qt 4.7

Rectangle {
    id: photostreamView
    width:  settings.pageWidth
    height: settings.pageHeight
    color:  settings.defaultBackgroundColor

    signal thumbnailClicked( string photoId, url photoUrl )
    property int currentPage: 1
    property string userid
    property bool loading: true

    // Model
    PhotostreamModel{
        id: photostreamModel
    }

    UserInfoModel{
        id: userInfoModel
    }

    // Connections to the C++ interface
    Connections{
        target: flickrManager
        onPhotostreamUpdated: { photostreamModel.xml = xml; loading = false;}
        onUserInfoUpdated: { userInfoModel.xml = xml}
    }

    // Simple delegate for images
    Component{
        id: delegate
        Item{

            width: photostreamGrid.cellWidth
            height: photostreamGrid.cellHeight
            property url mediumSizeUrl: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg"
            FlickrImage{

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                showBorder: true
                source:     url_s
                borderWidth: 3
                width:      settings.gridCellWidth
                height:     settings.gridCellHeight
                fillMode: Image.PreserveAspectCrop
                clip:  true
                showLoader: false
                transform: Rotation{origin.x: width/2; origin.y: height/2; axis { x: 0; y: 0; z: 1 } angle: Math.random() * 10 * (index % 2?-1:1) }
                smooth: true
                onClicked: photostreamView.thumbnailClicked(id, mediumSizeUrl);
            }            
        }
    }

    // Function to get next photostream page
    function nextPhotostreamPage()
    {
        loading = true;
        ++currentPage;        
        flickrManager.getPhotostream( userid, currentPage );
    }

    // Function to get previous photostream page
    function prevPhotostreamPage()
    {
        if ( currentPage == 1)
            return;
        loading = true;
        --currentPage;
        flickrManager.getPhotostream( userid, currentPage );
    }

    function loadMoreImages(){
        if (photostreamGrid.atYBeginning){
            prevPhotostreamPage();
            console.log("prev page");
        }else
        if (photostreamGrid.atYEnd){            
            nextPhotostreamPage();
            console.log("next page"+currentPage);
        }
    }




    // Because we get all the user data also as XML so let's create a view
    // for a single user information
    ListView{
        id:spacer
        height: 110
        width:  parent.width
        interactive: false
        anchors.top: parent.top
        model:  userInfoModel
        delegate:  UserInfoDelegate{}
    }

    GridView{
        id:             photostreamGrid
        anchors.top:    spacer.bottom
        anchors.topMargin:  10
        anchors.left:   parent.left        
        anchors.right:  parent.right        
        anchors.bottom: parent.bottom
        //anchors.bottomMargin: 10
        cellHeight:     settings.pageWidth / 4
        cellWidth:      settings.pageWidth / 4
        model:          photostreamModel
        delegate:       delegate
        //clip:           true
        opacity: loading ?0.2:1
        onMovementEnded: loadMoreImages();


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

    Item{
        anchors.fill: photostreamGrid
        visible: loading

        Loading{
            id: topLoadingIndicator
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

}
