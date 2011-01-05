import Qt 4.7

Item{
    width: settings.pageWidth
    height: settings.pageHeight


    Connections{
        target: flickrManager
        onRecentActivityUpdated: { activityModel.xml = xml}
    }

    Rectangle {
        color:"black"
        anchors.fill: parent
    }

    RecentActivityModel{ id: activityModel }

    Component{
        id: del
        Item{
            width: settings.pageWidth
            height: 30
            Text{
                anchors.fill: parent
                color: "white"
                text: title +",type: "+eventtype//+", comments: "+comments_
            }
        }
    }

    ListView {
        anchors.fill: parent
        model:  activityModel
        delegate: del
    }

}
