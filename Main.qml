import QtQuick 2.0
import Ubuntu.Components 1.1
import Ubuntu.Connectivity 1.0
import Ubuntu.Components.ListItems 0.1 as ListItem

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    id: root
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "networkstatus.ubuntu"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(50)
    height: units.gu(75)

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    Connections {
        target: NetworkingStatus
        // full status can be retrieved from the base C++ class
        // status property
        onStatusUpdated: {
            if (value === NetworkingStatus.Offline) {
                console.log("Status: Offline")
            }
            if (value === NetworkingStatus.Connecting) {
                console.log("Status: Connecting")
            }
            if (value === NetworkingStatus.Online) {
                console.log("Status: Online")
            }

            online.subText = NetworkingStatus.online ? "yes" : "no";
        }

        onWifiEnabledUpdated: {
            console.log("wifiEnabledUpdated: " + NetworkingStatus.WifiEnabled);
        }

        onFlightModeUpdated: {
           console.log("FlightModeUpdated: " + NetworkingStatus.flightMode);
           flightMode.subText = NetworkingStatus.flightMode ? "yes" : "no"
        }

        onHotspotEnabledUpdated: {
            console.log("hotspotEnabledUpdated: " + NetworkingStatus.hotspotEnabled)
            hotspotEnabled.subText = etworkingStatus.hotspotEnabled ? "yes" : "no"
        }

        onUnstoppableOperationHappeningUpdated: {
            console.log("unstoppableOperationHappeningUpdated: " + NetworkingStatus.UnstoppableOperationHappening);
        }

        onWifiSwitchEnabledUpdated: {
            console.log("wifiSwitchEnabledUpdated: " + NetworkingStatus.wifiSwitchEnabled);
        }

        onFlightModeSwitchEnabledUpdated: {
            console.log("flightModeSwitchEnabledUpdated: " + NetworkingStatus.flightModeSwitchEnabled);
        }

        onHotspotSsidUpdated: {
            console.log("hotspotSsidUpdated: " + NetworkingStatus.hotspotSsid);
        }

        onHotspotPasswordUpdated: {
            console.log("hotspotPasswordUpdated: " + NetworkingStatus.password);
            hotspotPassword.subText = NetworkingStatus.password;
        }

        onHotspotStoredUpdated: {
            console.log("hotspotStoredUpdated: " + NetworkingStatus.hotspotStored);
        }

        onInitialized: {
            console.log("initialized");
        }
    }

    function getStatus(status) {
        console.log("status: " + status);
        switch(status) {
        case 0:
            return "Offline";
        case 1:
            return "Connecting";
        case 2:
            return "Online"
        }
    }

    Page {
        title: i18n.tr("Networking Status")

        ListModel {
            id: mymodel
        }

        Flickable {
            id: scrollWidget
            anchors.fill: parent
            contentHeight: contentItem.childrenRect.height
            boundsBehavior: (contentHeight > root.height) ? Flickable.DragAndOvershootBounds :
                                                            Flickable.StopAtBounds
            flickableDirection: Flickable.VerticalFlick

            Column {
                id: layout
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: units.gu(1)

                ListItem.Subtitled {
                    id: online
                    text: i18n.tr("online")
                    subText: NetworkingStatus.online ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: bandwidth
                    text: i18n.tr("Bandwith")
                    subText: NetworkingStatus.limitedBandwith ? "Bandwith limited" : "Bandwith not limited"
                }

                ListItem.Subtitled {
                    id: flightMode
                    text: i18n.tr("flight mode")
                    subText: NetworkingStatus.flightMode ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: status
                    text: i18n.tr("Status")
                    subText: getStatus(NetworkingStatus.Status)
                }

                ListItem.Subtitled {
                    id: wifiEnabled
                    text: i18n.tr("wifiEnabled")
                    subText: NetworkingStatus.wifiEnabled ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: flightModeSwichEnabled
                    text: i18n.tr("FlightModeSwitchEnabled")
                    subText: NetworkingStatus.FlightModeSwitchEnabled ? "yes" : "no"
                }

                ListItem.Subtitled {
                    text: i18n.tr("WifiSwitchEnabled")
                    subText: NetworkingStatus.WifiSwitchEnabled ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: hotspotSwitchEnabled
                    text: i18n.tr("HotspotSwitchEnabled")
                    subText: NetworkingStatus.HotspotSwitchEnabled ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: hotspotEnabled
                    text: i18n.tr("hotspotEnabled")
                    subText: NetworkingStatus.hotspotEnabled ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: hotspotPassword
                    text: i18n.tr("hotspotPassword")
                    subText: NetworkingStatus.hotspotPassword
                }

                ListItem.Subtitled {
                    id: hotspotStored
                    text: i18n.tr("hotspotStored")
                    subText: NetworkingStatus.hotspotStored ? "yes" : "no"
                }

                ListItem.Subtitled {
                    id: initialized
                    text: i18n.tr("Initialized")
                    subText: NetworkingStatus.Initialized ? "yes" : "no"
                }
            }
        }
    }
}

