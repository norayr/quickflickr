import Qt 4.7

Item{
    id: flickrText

    property alias text: body.text
    property alias elide: body.elide
    property alias textFormat: body.textFormat
    property alias wrapMode: body.wrapMode
    property color headerColor: settings.textHeaderColor
    property string header
    property int fontPixelSize: settings.smallFontSize

    height:  body.paintedHeight
    width:  header.paintedWidth+10+body.paintedWidth
    Row{
        spacing: 10
        anchors.fill: parent

        Text {
            id: header
            color:  headerColor
            font.bold: true
            font.pixelSize: fontPixelSize
            text:  flickrText.header + ":"
            visible: flickrText.header != ""
        }

        Text {
            id: body
            color: settings.fontColor
            smooth:  true
            font.pixelSize: fontPixelSize
            width: flickrText.width - header.paintedWidth
        }
    }
}
