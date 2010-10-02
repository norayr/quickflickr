import Qt 4.7

Item {
    
    property alias title: titleText.text
    property alias description: descriptionText.text
    property alias tags: tagsText.text
    property alias dateTaken: dateText.text
    property alias views: viewsText.text
    
    Flickable{
        id: flickable
        flickableDirection: Flickable.VerticalFlick            
        anchors.fill: parent                 
        contentHeight: layout.childrenRect.height + 30
        clip: true
        
        Column{
            id: layout
            spacing: 20
            anchors.left: parent.left
            anchors.right: parent.right            
            
            // Spacer item
            Item{                
                height: 20
                width: 30                
            }
            
            Text{
                id: titleText            
                font.family: "Helvetica"
                font.pointSize: 22
                font.bold: true
                color: "white"
                smooth: true                                                             
            }
            
            // These should be in a single row
            Row{                    
                spacing: 10
                Text{
                    text: "Date:"                    
                    smooth: true
                    font.family: "Helvetica"; 
                    font.pointSize: 15; 
                    color: "white"
                    font.bold: true                                            
                }
                Text{
                    id: dateText                                 
                    smooth: true
                    font.family: "Helvetica"; 
                    font.pointSize: 15; 
                    color: "white"                    
                }
                
                Item{
                    width: 30
                }

                Text{
                    text: "Views:"                    
                    smooth: true
                    font.family: "Helvetica"; 
                    font.pointSize: 15; 
                    color: "white"
                    font.bold: true                                            
                }
                Text{
                    id: viewsText                                 
                    smooth: true
                    font.family: "Helvetica"; font.pointSize: 15; color: "white"
                }
            }

            Rectangle{             
                height:2
                width: parent.width - 20
                color: "white"
            }
    
            Text{
                id: descriptionText            
                font.family: "Arial"
                font.pointSize: 15            
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere            
                color: "white"
                smooth: true            
                width: parent.width - 20
                
                textFormat: Text.RichText
                
                onLinkActivated:{webview.urlString = link; fullScreenViewer.state = 'WebView'; }
            }  
            
            Rectangle{                
                height:2
                width: parent.width - 20
                color: "white"
            }
            
            Text{
                text: "Tags:"                    
                smooth: true
                font.family: "Helvetica"; 
                font.pointSize: 15; 
                color: "white"
                font.bold: true                                            
            }
            Text{
                id: tagsText                     
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                smooth: true
                font.family: "Helvetica"; font.pointSize: 15; color: "white"
                width: parent.width - 20
            }
            
        }
        ScrollBar {            
            scrollArea: flickable; width: 8
            anchors { right: parent.right; top: parent.top; bottom: parent.bottom; bottomMargin:5; topMargin:5 }                        
            
        }
    }                
            
    
    
}
