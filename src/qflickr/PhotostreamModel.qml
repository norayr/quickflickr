import Qt 4.7

XmlListModel {    
    query: "/rsp/photos/photo"    
    XmlRole { name: "owner"; query: "@owner/string()" }    
    XmlRole { name: "url_m"; query: "@url_m/string()" }
    XmlRole { name: "url_s"; query: "@url_s/string()" }
    XmlRole { name: "ownername"; query: "@owner_name/string()" }    
    XmlRole { name: "server"; query: "@server/string()" }     
    XmlRole { name: "farm"; query: "@farm/string()" }     
    XmlRole { name: "id"; query: "@id/string()" }     
    XmlRole { name: "secret"; query: "@secret/string()" }
}

