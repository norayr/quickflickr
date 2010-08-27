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
    XmlRole { name: "eventowner"; query: "@ownername[1]/string()" }
    
    // Some hardcoding. I couldn't figure out how to get correct data out
    // from XML using query. It' might also be a bug in QML side, but not sure.
    XmlRole { name: "event1"; query: "activity/event[1]/string()" }
    XmlRole { name: "event2"; query: "activity/event[2]/string()" }
    XmlRole { name: "event3"; query: "activity/event[3]/string()" }
    XmlRole { name: "event4"; query: "activity/event[4]/string()" }
    XmlRole { name: "event5"; query: "activity/event[5]/string()" }
    XmlRole { name: "event6"; query: "activity/event[6]/string()" }
    
 
}
