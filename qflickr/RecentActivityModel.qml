import Qt 4.7


XmlListModel {
    
    query: "/rsp/items/item"    
    XmlRole { name: "title"; query: "title/string()" }    
    XmlRole { name: "type"; query: "@type/string()" }
    XmlRole { name: "id"; query: "@id/string()" }
    XmlRole { name: "owner"; query: "@owner/string()" }
    XmlRole { name: "ownername"; query: "@ownername/string()" }
    XmlRole { name: "secret"; query: "@secret/string()" }
    XmlRole { name: "server"; query: "@server/string()" }
    XmlRole { name: "farm"; query: "@farm/string()" }    
    XmlRole { name: "comments"; query: "@comments/string()" }
    XmlRole { name: "faves"; query: "@faves/string()" }
    XmlRole { name: "views"; query: "@views/string()" }
    XmlRole { name: "notes"; query: "@notes/string()" }        
     
}
