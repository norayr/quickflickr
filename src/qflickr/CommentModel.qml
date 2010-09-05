import Qt 4.7


XmlListModel {
    
    query: "/rsp/comments/comment"    
    XmlRole { name: "author"; query: "@author/string()" }    
    XmlRole { name: "authorname"; query: "@authorname/string()" }
    XmlRole { name: "datecreate"; query: "@datecreate/number()" }
    XmlRole { name: "comment"; query: "string()" }    
}
