import QtQuick 2

Item{
    id: recentActivityView
    signal thumbnailClicked( string photoId, url photoUrl )
    property bool isModelUpdated: false
    width: settings.pageWidth
    height: settings.pageHeight


    Connections{
        target: flickrManager
        onRecentActivityUpdated: { activityModel.xml = xml; isModelUpdated = true;}
    }

    Rectangle {
        color:"black"
        anchors.fill: parent
    }

    RecentActivityModel{ id: activityModel }

    Component{
        id: del
        Item{
            property url mediumSizeUrl: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+".jpg"
            width: settings.pageWidth
            height: childrenRect.height



            Text{
                id: titleText
                anchors.left: parent.left
                anchors.leftMargin: settings.largeMargin
                anchors.top: parent.top
                color: "white"
                text: title
                smooth: true
                font.pixelSize: settings.mediumFontSize
                elide: Text.ElideRight
            }
            FlickrImage{
                id: image
                source: "http://farm"+farm+".static.flickr.com/"+server+"/"+id+"_"+secret+"_m.jpg"
                anchors.top: titleText.bottom
                anchors.left: parent.left
                anchors.margins: settings.largeMargin
                smooth: true
                showLoader: false
                width: 100
                height: 100
                fillMode: Image.PreserveAspectCrop
                clip:  true
                transform: Rotation{origin.x: width/2; origin.y: height/2; axis { x: 0; y: 0; z: 1 } angle: Math.random() * 5 * (index % 2?-1:1) }
            }

            FlickrText{
                id: commentsText
                anchors.left: image.right
                anchors.leftMargin: settings.largeMargin
                anchors.top:  titleText.bottom
                anchors.topMargin: settings.mediumMargin
                header: "Comments"
                text: comments
            }
            FlickrText{
                id: favesText
                anchors.left: image.right
                anchors.leftMargin: settings.largeMargin
                anchors.top:  commentsText.bottom
                anchors.topMargin: settings.mediumMargin
                header: "Faves"
                text: faves
            }
            FlickrText{
                id: viewsText
                anchors.left: image.right
                anchors.leftMargin: settings.largeMargin
                anchors.top:  favesText.bottom
                anchors.topMargin: settings.mediumMargin
                header: "Views"
                text: views
            }
            MouseArea{
                anchors.fill: parent
                onClicked: recentActivityView.thumbnailClicked( id, mediumSizeUrl)
            }

        }
    }

    ListView {
        anchors.fill: parent
        model:  activityModel
        delegate: del
        spacing:  settings.hugeMargin

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

}
