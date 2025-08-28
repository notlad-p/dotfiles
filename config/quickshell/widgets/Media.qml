import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.services
import qs.components
import qs.config

BarButton {
    id: root
    marginX: Players.list.length === 0 ? 8 : 12
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    function lengthStr(length: int): string {
        if (length < 0)
            return "-1:-1";

        const hours = Math.floor(length / 3600);
        const mins = Math.floor((length % 3600) / 60);
        const secs = Math.floor(length % 60).toString().padStart(2, "0");

        if (hours > 0)
            return `${hours}:${mins.toString().padStart(2, "0")}:${secs}`;
        return `${mins}:${secs}`;
    }

    RowLayout {
        spacing: 8
        Layout.alignment: Qt.AlignVCenter

        Icon {
            visible: Players.list?.length === 0
            size: 16
            iconColor: Colors.white
            iconName: "music"
        }

        Icon {
            visible: Players.list.length > 0
            size: 16
            iconColor: Players.getIconColor(Players.trackedPlayer?.identity)
            iconName: Players.getIconName(Players.trackedPlayer?.identity)
        }

        WrapperItem {
            id: trackTitleItem
            visible: Players.list?.length > 0
            property int spacing: 20
            property int maxWidth: 175
            property string trackStr: `${Players.trackedPlayer?.trackTitle || ""} – ${Players.trackedPlayer?.trackArtist || ""}`
            Layout.maximumWidth: maxWidth
            clip: true

            StyledText {
                id: trackTitleText
                text: trackTitleItem.trackStr
                color: Colors.white
                font.weight: Font.Bold

                StyledText {
                    id: wrapTitleText
                    text: trackTitleItem.trackStr
                    color: Colors.white
                    font.weight: Font.Bold
                    x: trackTitleText.implicitWidth + trackTitleItem.spacing
                }

                SequentialAnimation on x {
                    id: textScrollAnimation
                    running: false
                    loops: Animation.Infinite
                    PauseAnimation {
                        duration: 1000
                    }
                    NumberAnimation {
                        from: 0
                        to: -trackTitleText.implicitWidth - trackTitleItem.spacing
                        duration: {
                            // calculate duration as pixels per second (180 pixels per second)
                            const distance = wrapTitleText.implicitWidth * 2 + trackTitleItem.spacing;
                            const dur = distance / 180 * 1000;
                            return dur;
                        }
                    }
                }
            }
        }

        TapHandler {
            acceptedButtons: Qt.MiddleButton
            onTapped: Players.trackedPlayer?.togglePlaying()
        }

        HoverHandler {
            id: buttonHoverHandler
            onHoveredChanged: () => {
                if (hovered && trackTitleText.implicitWidth > trackTitleItem.maxWidth) {
                    textScrollAnimation.running = true;
                } else {
                    textScrollAnimation.running = false;
                    trackTitleText.x = 0;
                }
            }
        }
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {

                WrapperRectangle {
                    visible: Players.list?.length === 0
                    margin: 8
                    color: Colors.black700
                    radius: 8
                    RowLayout {
                        spacing: 8

                        Icon {
                            size: 16
                            iconColor: "#1ED760"
                            iconName: "spotify"
                        }

                        StyledText {
                            text: "Launch Spotify"
                            font.weight: Font.Bold
                        }
                    }
                }

                MediaPlayer {
                    visible: Players.list.length > 0
                    player: Players.trackedPlayer
                }
            }

            // ColumnLayout {
            //     Text {
            //         text: {
            //             console.log(Network);
            //             return "Network Service Test";
            //         }
            //         font.bold: true
            //         color: "white"
            //     }
            //
            //     Repeater {
            //         Layout.fillWidth: true
            //         Layout.fillHeight: true
            //         model: Network.devices.values
            //
            //         delegate: WrapperRectangle {
            //             width: parent.width
            //             color: "transparent"
            //             border.color: palette.button
            //             border.width: 1
            //             margin: 10
            //
            //             ColumnLayout {
            //                 Text {
            //                     text: {
            //                         return `Device #${index}: ${modelData.name}`;
            //                     }
            //                     font.bold: true
            //                     color: "white"
            //                 }
            //
            //                 Text {
            //                     text: {
            //                         return `Address: ${modelData.address}`;
            //                     }
            //                     font.bold: true
            //                     color: "white"
            //                 }
            //
            //                 Text {
            //                     text: "Type: " + NetworkDeviceType.toString(modelData.type)
            //                     color: "white"
            //                 }
            //
            //                 Text {
            //                     text: "State: " + NetworkDeviceState.toString(modelData.state)
            //                     color: "white"
            //                 }
            //
            //                 Text {
            //                     visible: modelData.type === NetworkDeviceType.Wireless
            //                     // text: "Scanning: " + modelData.scanning
            //                     text: "Last Scan: " + modelData.lastScan
            //                     color: "white"
            //
            //                     TapHandler {
            //                         onTapped: {
            //                             console.log("clicked scan");
            //                             modelData.scan();
            //                         }
            //                     }
            //
            //
            //                     Connections {
            //                         target: modelData
            //                         ignoreUnknownSignals: true
            //                         function onLastScanChanged(lastScan) {
            //                             console.log("LAST SCAN CHANGED: ", lastScan);
            //                         }
            //                     }
            //                 }
            //                 //
            //                 // Text {
            //                 //     visible: modelData.type === NetworkDeviceType.Wireless
            //                 //     // NOTE: last scan will be null at first
            //                 //     text: {
            //                 //         // console.log("Last scan: ", modelData.lastScan);
            //                 //         modelData.onLastScanChanged.connect(() => {
            //                 //             console.log("LAST SCAN CHANGED!!!!!!!!!!!");
            //                 //         });
            //                 //         return `Last Scan: ${modelData.lastScan ? Qt.formatDateTime(modelData.lastScan, "yyyy-MM-dd hh:mm:ss") : ""}`;
            //                 //         // return "Last scan?";
            //                 //     }
            //                 //     color: "white"
            //                 // }
            //                 //
            //                 // Text {
            //                 //     visible: modelData.type === NetworkDeviceType.Wireless
            //                 //     text: "NETWORKS:"
            //                 //     color: "white"
            //                 // }
            //                 //
            //                 // Repeater {
            //                 //     enabled: modelData.type === NetworkDeviceType.Wireless
            //                 //     Layout.fillWidth: true
            //                 //     Layout.fillHeight: true
            //                 //     model: modelData.networks.values
            //                 //
            //                 //     delegate: WrapperRectangle {
            //                 //         width: parent.width
            //                 //         color: "transparent"
            //                 //         border.color: palette.button
            //                 //         border.width: 1
            //                 //         margin: 10
            //                 //
            //                 //         ColumnLayout {
            //                 //             Text {
            //                 //                 text: "SSID: " + modelData.ssid
            //                 //                 color: "white"
            //                 //             }
            //                 //
            //                 //             Text {
            //                 //                 text: "Signal: " + modelData.signal
            //                 //                 color: "white"
            //                 //             }
            //                 //
            //                 //             Text {
            //                 //                 text: "Connected: " + modelData.connected
            //                 //                 color: "white"
            //                 //             }
            //                 //         }
            //                 //     }
            //                 // }
            //             }
            //         }
            //     }
            // }
        }
    }
}
