/**
 * QuickFlickr - Flickr client for mobile devices.
 *
 * Author: Marko Mattila (marko.mattila@d-pointer.com)
 *         http://www.d-pointer.com
 *
 *  QuickFlickr is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  QuickFlickr is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with QuickFLickr.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.15
import QtQuick.XmlListModel 2

XmlListModel {
    
    query: "/rsp/photos/photo"    
    XmlRole { name: "id"; query: "@id/string()" }    
    XmlRole { name: "owner"; query: "@owner/string()" }
    XmlRole { name: "ownername"; query: "@ownername/string()" }
    XmlRole { name: "secret"; query: "@secret/string()" }
    XmlRole { name: "server"; query: "@server/string()" }    
    XmlRole { name: "farm"; query: "@farm/string()" }    
    XmlRole { name: "title"; query: "@title/string()" }    
    XmlRole { name: "url_s"; query: "@url_s/string()" }
    XmlRole { name: "height"; query: "@height_m/string()" }    
    XmlRole { name: "width"; query: "@width_m/string()" }    
}
