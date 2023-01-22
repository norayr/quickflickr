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


Rectangle{
    id: mainView

    // Settigs object initialization. It holds all the application
    // level settings.
    Settings{ id: settings }

    width: settings.width
    height: settings.height
    color: "gray"

    // Create a MainMenu
    MainMenu{
        id: mainMenu
        anchors.fill: parent
    }
    
    // Wait information from C++ side, should we authenticate first
    // or just show the normal menu
    Connections{
        target: flickrManager
        onProceed: {mainMenu.state = 'Menu';
                    flickrManager.getLatestContactUploads();                    
                    }

        onAuthenticationRequired: {mainMenu.authUrl = authUrl;
                                   mainMenu.state = 'authenticate';}
    }            
}
