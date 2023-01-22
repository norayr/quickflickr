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
import QtQuick 2

Item{
    //width: 360
    //height: 640
    width:  deviceProfile.displayWidth()
    height: deviceProfile.displayHeight()

    property color defaultBackgroundColor: "black"

    property int navigationBarHeight: 80
    property int pageHeight: height - navigationBarHeight
    property int pageWidth: width

    property int gridCellHeight: 100
    property int gridCellWidth: 100

    property int scrollbarWidth: 8

    //Fonts
    property int tinyFontSize: 14
    property int smallFontSize: 16
    property int mediumFontSize: 20
    property int largeFontSize: 24
    property color fontColor: "white"

    // Margins
    property int smallMargin: 2
    property int mediumMargin: 5
    property int largeMargin: 10
    property int hugeMargin: 15

    property color separatorColor: "white"
    property color textHeaderColor: "steelblue"
}
