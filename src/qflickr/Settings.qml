import Qt 4.7

Item{
    width: 480
    height: 800
    property color defaultBackgroundColor: "black"

    property int navigationBarHeight: 80
    property int pageHeight: height - navigationBarHeight
    property int pageWidth: width

    property int gridCellHeight: 100
    property int gridCellWidth: 100

    property int scrollbarWidth: 8

    //Fonts
    property int smallFontSize: 16
    property int mediumFontSize: 20
    property int largeFontSize: 24

    // Margins
    property int smallMargin: 2
    property int mediumMargin: 5
    property int largeMargin: 10


}
