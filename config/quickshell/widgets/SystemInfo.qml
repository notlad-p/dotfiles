import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.UPower
// import Quickshell.Bluetooth

import qs.components
import qs.config

BarButton {
    id: root
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    Icon {
        visible: UPower.onBattery
        size: 16
        iconColor: Colors.white
        iconName: "battery-70"
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "bluetooth"
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "wifi-4-bar"
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        // loading: true
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {
                spacing: 12

                // WrapperRectangle {
                //     color: Colors.black700
                //     margin: 8
                //
                //     Text {
                //         // text: Bluetooth.defaultAdapter.discovering ? "Scaning" : "Scan"
                //         text: Bluetooth.defaultAdapter.discovering ? "Discovering" : "Not Discovering"
                //         color: "white"
                //     }
                //
                //     TapHandler {
                //         onTapped: {
                //             Bluetooth.defaultAdapter.discovering = !Bluetooth.defaultAdapter.discovering;
                //         }
                //     }
                // }

                // Bluetooth.defaultAdapter.discoverable
                // Bluetooth.defaultAdapter.discoverableTimeout
                // Bluetooth.defaultAdapter.enabled
                // Bluetooth.defaultAdapter.state
                // Bluetooth.defaultAdapter.pairable
                // Bluetooth.defaultAdapter.pairableTimeout

                // Repeater {
                //     model: Bluetooth.devices.values.filter(dev => dev.deviceName !== "")
                //
                //     delegate: WrapperRectangle {
                //         color: Colors.black700
                //
                //         ColumnLayout {
                //             StyledText {
                //                 text: `Name: ${modelData.deviceName}`
                //             }
                //
                //             StyledText {
                //                 text: `DBus Path: ${modelData.dbusPath}`
                //             }
                //
                //             StyledText {
                //                 text: `Paired: ${modelData.paired}`
                //             }
                //
                //             StyledText {
                //                 text: `Address: ${modelData.address}`
                //             }
                //
                //             StyledText {
                //                 text: `Battery Available: ${modelData.batteryAvailable}`
                //             }
                //
                //             StyledText {
                //                 visible: modelData.batteryAvailable
                //                 text: `Battery: ${modelData.battery}`
                //             }
                //
                //             StyledText {
                //                 text: `Battery Available: ${modelData.batteryAvailable}`
                //             }
                //         }
                //     }
                // }

                // Repeater {
                //     model: UPower.devices.values
                //
                //     delegate: WrapperRectangle {
                //         color: Colors.black700
                //
                //         ColumnLayout {
                //             StyledText {
                //                 text: `Name: ${modelData.model}`
                //             }
                //
                //             StyledText {
                //                 text: `Name: ${modelData.iconName}`
                //             }
                //         }
                //     }
                // }
            }
        }
    }
}
