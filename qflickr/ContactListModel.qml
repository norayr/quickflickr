import Qt 4.7

XmlListModel {
    
    query: "/rsp/photos/photo"    
    XmlRole { name: "owner"; query: "@owner/string()" }    
    XmlRole { name: "url"; query: "@url_s/string()" }
    XmlRole { name: "title"; query: "@title/string()" }
    XmlRole { name: "username"; query: "@username/string()" }
    XmlRole { name: "datetaken"; query: "@datetaken/string()" }     
}
