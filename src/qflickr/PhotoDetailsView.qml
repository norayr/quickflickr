import Qt 4.7

Rectangle{
    // Photo id
    property string id
    // source for an image
    property alias source: fullsize.source

    width: settings.pageWidth
    height: settings.pageHeight
    color:  settings.defaultBackgroundColor
    Image{
        id: fullsize
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 400
        fillMode: Image.PreserveAspectFit
        smooth: true
    }
}
