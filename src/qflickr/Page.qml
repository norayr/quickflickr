import Qt 4.7

// TODO: Add some nice way to add elements in this element.

Image{
    id: page_
    property alias title: navigationBar.text
    property alias showCloseButton: navigationBar.showCloseButton
    property bool hideNavigationBar: false
    anchors.fill: parent        
    source: "qrc:///gfx/gfx/background.png"
    signal backClicked
    
    NavigationBar{ 
        id: navigationBar        
        x:0
        y:0
        width: 800
        height: 60
        onBackClicked: parent.backClicked();
    }
    
    states: [
        State {
            name: "FullscreenState"
            when: hideNavigationBar == true
            PropertyChanges {
                target: navigationBar
                y: -60
                
            }
        }        
    ]
    
    
    transitions: 
        Transition {            
            PropertyAnimation{ target: navigationBar; property: "y"; duration: 400; easing.type: Easing.InOutQuad}                                
        }                
    
}
