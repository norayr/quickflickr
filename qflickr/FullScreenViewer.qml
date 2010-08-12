import Qt 4.7

ListView{
    //property alias photoStreamModel: model
    id: fullScreenViewer
    model: photoStreamModel
    delegate: FullScreenDelegate { id: fullScreenDelegate}
    width: 800
    height: 480
    orientation: "Horizontal"
    snapMode: ListView.SnapOneItem
    spacing: 20
    focus: true
    cacheBuffer: 1600
}
