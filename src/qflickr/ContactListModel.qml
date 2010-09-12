import Qt 4.7

XmlListModel {
    
    query: "/rsp/photos/photo"    
    XmlRole { name: "owner"; query: "@owner/string()" }        
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "username"; query: "@username/string()" }
    XmlRole { name: "datetaken"; query: "@datetaken/string()" }     
    XmlRole { name: "farm"; query: "@farm/string()" }
    XmlRole { name: "server"; query: "@server/string()" }
    XmlRole { name: "id"; query: "@id/string()" }
    XmlRole { name: "secret"; query: "@secret/string()" }
}
