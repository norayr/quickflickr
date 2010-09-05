import Qt 4.7

XmlListModel {
    
    query: "/rsp/photos/photo"    
    XmlRole { name: "id"; query: "@id/string()" }    
    XmlRole { name: "owner"; query: "@owner/string()" }
    XmlRole { name: "ownername"; query: "@ownername/string()" }
    XmlRole { name: "secret"; query: "@secret/string()" }
    XmlRole { name: "server"; query: "@server/string()" }    
    XmlRole { name: "farm"; query: "@farm/string()" }    
    XmlRole { name: "title"; query: "@title/string()" }    
    XmlRole { name: "url"; query: "@url_m/string()" }    
    XmlRole { name: "height"; query: "@height_m/string()" }    
    XmlRole { name: "width"; query: "@width_m/string()" }    
}
