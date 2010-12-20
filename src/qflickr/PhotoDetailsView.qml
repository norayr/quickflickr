import Qt 4.7

Rectangle{    
    id: photoViewer    
    property bool loading: false       
    color:  settings.defaultBackgroundColor


    // Update the view if FlickrManager emits signals
    Connections{
        target: flickrManager
        onPhotoInfoUpdated: {photoDetailsModel.xml = xml; photoViewer.loading = false; console.log(xml)}
    }

    PhotoDetailsModel{ id: photoDetailsModel }

    // Image details under the large image
    ListView{
        id: photoDetailsList
        model: photoDetailsModel
        delegate: PhotoDetailsDelegate{}
        width: settings.pageWidth        
    }   

}
