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


Item{
    id: mainMenu
    property alias authUrl: authenticationView.authenticationUrl
    property int viewOffset: 0

    // Background
    Rectangle{
        anchors.fill: parent
        color: "black"
    }

    PhotoDetailsView{
        id: photoDetails
        anchors.top: bottomBar.bottom
        anchors.left: bottomBar.left
        anchors.right: bottomBar.right
        height: settings.pageHeight
        opacity:  0
    }

    Timelineview{
        id: startupView
        x: 0
        y: 0
        onThumbnailClicked: {
            photostream.clear();
            flickrManager.getPhotostream(owner,1);
            flickrManager.getUserInfo( owner )
            photostream.userid = owner;            
            mainMenu.state = "photostream";
        }
    }

    RecentActivityView{
        id: activityView
        anchors.left: startupView.right
        anchors.top: startupView.top
        anchors.bottom:  startupView.bottom        
        onThumbnailClicked: {
            flickrManager.getPhotoInfo(photoId);
            mainMenu.state = "details"
        }
    }

    PhotostreamView{
        id: photostream

        anchors.left: activityView.right
        anchors.top: activityView.top
        anchors.bottom:  activityView.bottom        
        onThumbnailClicked: {            
            flickrManager.getPhotoInfo(photoId);            
            mainMenu.state = "details"
        }
    }

    ContactListView{
        id: contactsView
        width: settings.pageWidth
        height: settings.pageHeight

        anchors.left: photostream.right
        anchors.top: photostream.top
        anchors.bottom:  photostream.bottom

        onClicked: {
            photostream.userid = nsid;
            photostream.clear();
            flickrManager.getPhotostream( nsid, 1 );
            flickrManager.getUserInfo( nsid )
            mainMenu.state = "photostream";
        }
    }

    FavoritesView{
        id: favoritesView
        width: settings.pageWidth
        height: settings.pageHeight

        anchors.left: contactsView.right
        anchors.top: contactsView.top
        anchors.bottom:  contactsView.bottom

        onThumbnailClicked: {
            flickrManager.getPhotoInfo(photoId);
            mainMenu.state = "details"
        }
    }

    SettingsView{
        id: settingsView
        anchors.left: favoritesView.right
        anchors.top: favoritesView.top
        anchors.bottom:  favoritesView.bottom
        width:  settings.pageWidth
        height: settings.pageHeight

    }
    AuthenticationView{
        id: authenticationView
        x:0
        y:settings.height
        opacity: 0
        z: 5
    }



    // Model for a menu
    ListModel{
        id: lmodel
        ListElement {
             name: "Recent Uploads"
             strId: "startup"
         }
         ListElement {
            name: "Recent Activity"
            strId: "activity"
         }
         ListElement {
             name: "Photostream"
             strId: "photostream"
         }
         ListElement {
             name: "Contacts"
             strId: "contacts"
         }
         ListElement {
             name: "Favorites"
             strId: "favorites"
         }
         ListElement {
             name: "Settings & About"
             strId: "settings"
         }
         
         ListElement {
             name: "Minimize"
             strId: "minimize"
         }
         
         ListElement {
             name: "Exit"
             strId: "exit"
         }
    }

    // Navigatiobar at the bottom of the page.
    NavigationBar{
        id: bottomBar;
        model:  lmodel
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right
        onItemSelected: {
            if ( id == "startup"){
                viewOffset = 0;
                mainMenu.state = id;
            }else                                                
            if (id == "activity"){
                if ( !activityView.isModelUpdated ){
                    flickrManager.getRecentActivity();
                }
                viewOffset = -settings.pageWidth;
                mainMenu.state = id;
                console.log("Activating activity")
            }else
            if ( id == "photostream"){
                if ( mainMenu.state != "details"){
                    photostream.userid = flickrManager.nsid();
                    flickrManager.getPhotostream( flickrManager.nsid(), 1 );
                    flickrManager.getUserInfo( flickrManager.nsid());
                }

                viewOffset = -settings.pageWidth * 2;
                mainMenu.state = id;
            }
            else
            if ( id == "contacts" ){
                if ( !contactsView.isModelUpdated ){
                    flickrManager.getContacts();
                }

                viewOffset = -settings.pageWidth * 3;
                mainMenu.state = id;
            }
            if ( id == "favorites" ){
                flickrManager.getFavorites(24, 1);
                viewOffset = -settings.pageWidth * 4;
                mainMenu.state = id;
            }
            else
            if ( id == "settings" ){
                viewOffset = -settings.pageWidth * 5;
                mainMenu.state = id;
            }
            else
            if ( id == "minimize" ){
                mainWindow.minimize();
            }
            else
            if ( id == "exit" ){
                mainWindow.close();
            }

        }
    }


    states:[
        State{
            name: "startup"
            PropertyChanges {
                target: startupView
                x: 0
                y: 0
            }            
            PropertyChanges{
                target: bottomBar
                currentIndex: 0
            }
        },
        State{
            name: "activity"
            PropertyChanges {
                target: startupView
                x: -settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 1
            }
        },
        State {
            name: "photostream"

            PropertyChanges {
                target: startupView
                x: -2*settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 2
            }
        },        
        State {
            name: "contacts"
            PropertyChanges {
                target: startupView
                x: -3*settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 3
            }
        },
        State {
            name: "favorites"
            PropertyChanges {
                target: startupView
                x: -4*settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 4
            }
        },
        State {
            name: "settings"
            PropertyChanges {
                target: startupView
                x: -5*settings.pageWidth
                y: 0
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: 5
            }
        },
        State {
            name: "details"
            AnchorChanges{
                target: photoDetails
                anchors.top: mainMenu.top
                anchors.left: bottomBar.left
                anchors.right: bottomBar.right
            }
            PropertyChanges{
                target: photoDetails
                opacity: 1
            }
            PropertyChanges {
                target: startupView
                y: -settings.pageHeight - settings.navigationBarHeight
                x: viewOffset
            }
            PropertyChanges{
                target: bottomBar
                currentIndex: currentIndex
            }
        },
        State{
            name: "authenticate"
            PropertyChanges{
                target: authenticationView
                y: 0
                opacity: 1
            }
            PropertyChanges {
                target: bottomBar
                opacity: 0

            }
        }
    ]
    
    transitions: [
        Transition{

            ParallelAnimation{

                AnchorAnimation{}
                SequentialAnimation{

                PropertyAnimation{
                    properties: "y"
                    duration: 700
                    easing.type: "OutCubic"
                }

                PropertyAnimation{
                    properties: "x"
                    duration: 700
                    easing.type: "OutCubic"
                }
                PropertyAnimation{
                    properties: "opacity"
                    duration: 700
                    easing.type: "OutCubic"
                }                
                }
            }
        }
    ]
}

