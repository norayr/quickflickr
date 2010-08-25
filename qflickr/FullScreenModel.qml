import Qt 4.7

XmlListModel {
    
    query: "/rsp/photos/photo"    
    XmlRole { name: "owner"; query: "@owner/string()" }    
    XmlRole { name: "url"; query: "@url_m/string()" }
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "username"; query: "@username/string()" }
    XmlRole { name: "datetaken"; query: "@datetaken/string()" }     
    XmlRole { name: "width"; query: "@width_m/string()" }     
    XmlRole { name: "height"; query: "@height_m/string()" }     
    XmlRole { name: "description"; query: "description/string()" }     
    XmlRole { name: "tags"; query: "@tags/string()" }     
    XmlRole { name: "views"; query: "@views_m/string()" }     
    XmlRole { name: "server"; query: "@server/string()" }     
    XmlRole { name: "farm"; query: "@farm/string()" }     
    XmlRole { name: "id"; query: "@id/string()" }     
}

