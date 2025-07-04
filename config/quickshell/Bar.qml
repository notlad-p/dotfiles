import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
// import Quickshell.Services.NetworkManager
// import Quickshell.Services.UPower as Upower

import "root:/widgets"
import "root:/widgets/LocalInfo"
import "root:/config"

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            margins {
                top: 8
                right: 8
                left: 8
            }

            implicitHeight: containerRect.implicitHeight

            Rectangle {
                id: containerRect
                anchors.fill: parent
                implicitHeight: itemsContainer.implicitHeight
                radius: 8
                color: Colors.black900

                Item {
                    id: itemsContainer
                    anchors.fill: containerRect
                    implicitWidth: parent.implicitWidth
                    implicitHeight: Math.max(left.implicitHeight, center.implicitHeight, right.implicitHeight)

                    RowLayout {
                        id: left
                        anchors.left: parent.left
                        anchors.leftMargin: 8
                        spacing: 8

                        OperatingSystem {}
                        Workspaces {
                            screen: modelData
                        }

                        // Text {
                        //     text: `${UPower.onBattery}`
                        // }
                    }

                    RowLayout {
                        id: center
                        spacing: 8
                        anchors.horizontalCenter: parent.horizontalCenter

                        Media {
                            id: media
                        }
                        LocalInfo {
                            id: localInfo
                        }
                    }

                    RowLayout {
                        id: right
                        anchors.right: parent.right
                        anchors.rightMargin: 8
                        spacing: 8

                        Tray {}
                        Screenshot {}
                        StopWatch {}
                        Sound {}
                        SystemInfo {}
                        Notifications {}
                        QuickSettings {}
                    }
                }
            }
        }
    }
}
