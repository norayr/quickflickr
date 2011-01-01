import Qt 4.7

// Model for containing information about users
XmlListModel {

    query: "/rsp/person"
    XmlRole { name: "nsid";         query: "@nsid/string()" }
    XmlRole { name: "ispro";        query: "@ispro/number()" }
    XmlRole { name: "iconserver";   query: "@iconserver/string()" }
    XmlRole { name: "iconfarm";     query: "@iconfarm/string()" }
    XmlRole { name: "realname";     query: "realname/string()" }
    XmlRole { name: "username";     query: "username/string()" }
    XmlRole { name: "geolocation";  query: "location/string()" } // Property name can't be location. It prints the object location in memory
    XmlRole { name: "firstdatetaken"; query: "photos/firstdatetaken/string()" }
    //XmlRole { name: "views";        query: "photos/views/string()" }
    XmlRole { name: "count";        query: "photos/count/string()" }
}
