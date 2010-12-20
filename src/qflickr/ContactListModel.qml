import Qt 4.7

XmlListModel {
    query: "/rsp/contacts/contact"
    XmlRole { name: "nsid"; query: "@nsid/string()" }
    XmlRole { name: "username"; query: "@username/string()" }
    XmlRole { name: "iconserver"; query: "@iconserver/string()" }
    XmlRole { name: "iconfarm"; query: "@iconfarm/string()" }
    XmlRole { name: "realname"; query: "@realname/string()" }
    XmlRole { name: "friend"; query: "@friend/string()" }
    XmlRole { name: "family"; query: "@family/string()" }
    XmlRole { name: "ignored"; query: "@ignored/string()" }
}
