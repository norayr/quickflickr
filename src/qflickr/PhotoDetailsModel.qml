import Qt 4.7

XmlListModel{
    query: "/rsp/photo"
    XmlRole { name: "isfavorite";   query: "@isfavorite/number()" }
    XmlRole { name: "ispro";        query: "@ispro/number()" }
    XmlRole { name: "id";           query: "@id/string()" }
    XmlRole { name: "server";       query: "@server/string()" }
    XmlRole { name: "secret";       query: "@secret/string()" }
    XmlRole { name: "farm";         query: "@farm/string()" }
    XmlRole { name: "iconserver";   query: "@iconserver/string()" }
    XmlRole { name: "iconfarm";     query: "@iconfarm/string()" }
    XmlRole { name: "realname";     query: "owner/@realname/string()" }
    XmlRole { name: "username";     query: "owner/@username/string()" }
    XmlRole { name: "geolocation";  query: "owner/@location/string()" } // Property name can't be location. It prints the object location in memory
    XmlRole { name: "datetaken";    query: "dates/@taken/string()" }
    XmlRole { name: "views";        query: "@views/string()" }
    XmlRole { name: "title";        query: "title/string()" }
    XmlRole { name: "description";  query: "description/string()" }
    XmlRole { name: "comments";     query: "comments/string()" }
    XmlRole { name: "tags";         query: "tags/string()" }
    XmlRole { name: "cancomment";   query: "editability/@cancomment/number()" }
}
