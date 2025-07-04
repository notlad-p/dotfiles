// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Io

import "root:/services"
import "root:/components"
import "root:/config"

PopupWindow {
    id: popup
    required property Item parentContainer
    default property alias content: row.data
    property bool isOpen: false
    property bool isClosing: false
    property real duration: 250

    visible: false
    anchor {
        // item: parentContainer
        window: parentContainer.QsWindow.window
        rect.x: popup.screen.width / 2 - popup.implicitWidth / 2
        rect.y: popup.screen.height / 2 - popup.implicitHeight
    }
    color: "transparent"
    implicitWidth: wrapperItem.implicitWidth
    implicitHeight: wrapperItem.implicitHeight

    Timer {
        id: closeTimer
        interval: popup.duration + 50
        onTriggered: {
            popup.isOpen = false;
            popup.visible = false;
        }
    }

    HyprlandFocusGrab {
        id: grab
        windows: [popup.parentContainer.QsWindow.window, popup]

        onActiveChanged: {
            if (!grab.active) {
                popup.isOpen = false;
            }
        }
    }

    function toggle() {
        popup.isOpen = !popup.isOpen;
    }

    // Watch for state change
    onIsOpenChanged: {
        if (isOpen) {
            closeTimer.stop();
            visible = true;
            grab.active = true;
        } else {
            closeTimer.start();
            grab.active = false;
        }
    }

    WrapperItem {
        id: wrapperItem
        topMargin: 2

        WrapperRectangle {
            id: containerRect
            property real margin: 16
            color: Colors.black900
            border.width: 1
            border.color: Qt.alpha(Colors.white, 0.05)
            radius: 8

            implicitWidth: row.implicitWidth + margin * 2
            implicitHeight: row.implicitHeight + margin * 2

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: popup.duration
                    easing.type: Easing.OutCubic
                }
            }
            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 50
                    easing.type: Easing.OutCubic
                }
            }

            opacity: popup.isOpen ? 1 : 0
            Behavior on opacity {
                NumberAnimation {
                    duration: popup.duration
                    easing.type: Easing.InOutCubic
                }
            }

            transform: [
                Scale {
                    id: scaleTransform
                    origin.x: containerRect.width / 2
                    origin.y: containerRect.height / 2
                    xScale: popup.isOpen ? 1 : 0.6
                    yScale: popup.isOpen ? 1 : 0.6

                    Behavior on xScale {
                        NumberAnimation {
                            duration: popup.duration
                            // easing.type: Easing.OutBack
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Behavior on yScale {
                        NumberAnimation {
                            duration: popup.duration
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            ]

            WrapperItem {
                id: row
                anchors.fill: parent
                anchors.margins: containerRect.margin

                RowLayout {
                    Repeater {
                        id: repeater
                        property var powerButtonsList: [
                            {
                                iconName: "power",
                                runCommand: ["bash", "-c", "systemctl poweroff || loginctl poweroff"]
                            },
                            {
                                iconName: "restart",
                                runCommand: ["bash", "-c", "systemctl reboot || loginctl reboot"]
                            },
                            {
                                iconName: "lock-screen",
                                runCommand: ["bash", "-c", "loginctl lock-session"]
                            },
                            {
                                iconName: "logout",
                                runCommand: ["bash", "-c", "hyprctl dispatch exit"]
                            },
                            {
                                iconName: "sleep",
                                runCommand: ["bash", "-c", "systemctl suspend || loginctl suspend"]
                            },
                            {
                                iconName: "hibernate",
                                runCommand: ["bash", "-c", "systemctl hibernate || loginctl hibernate"]
                            }
                            // TODO: buy wifi plug with api & call api here
                            // For now, use hyprctl for two main monitors
                            // {
                            //   iconName: "monitor-off",
                            //   command: []
                            // }
                        ]

                        model: powerButtonsList.length

                        delegate: Button {
                            id: powerButton

                            onClicked: buttonProc.running = true
                            Process {
                                id: buttonProc
                                command: repeater.powerButtonsList[index].runCommand
                                running: false
                            }

                            background: WrapperRectangle {
                                margin: 10
                                radius: 8
                                color: buttonHoverHandler.hovered ? Colors.black500 : Colors.black600

                                HoverHandler {
                                    id: buttonHoverHandler
                                    cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                                }

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 250
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Icon {
                                    iconName: repeater.powerButtonsList[index].iconName
                                    size: 20
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
