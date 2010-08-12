import Qt 4.7
//import "qflickr"

Rectangle{
    id: mainView
    width:800; height: 480;
    Image { source: "images/stripes.png"; fillMode: Image.Tile; anchors.fill:parent; opacity: 0.3 }
    color: "black";    
    MainMenu{ id: mainMenu }

}
