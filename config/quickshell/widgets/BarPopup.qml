// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.services
import qs.components
import qs.config

PopupWindow {
    id: popup
    required property Item parentContainer
    default property alias content: row.data
    property bool isOpen: false
    property bool isClosing: false
    property real duration: 275

    visible: false
    anchor {
        // item: parentContainer
        window: parentContainer.QsWindow.window
        rect.x: {
            const window = parentContainer.QsWindow.window;

            // This variable needed to force a binding update to keep the popup centered under the popup
            // button when the size of the popup button changes
            // https://quickshell.org/docs/v0.2.0/types/Quickshell/QsWindow/#windowTransform
            const seeminglyUselessVaraible = popup.windowTransform;

            if (window?.contentItem) {
                const itemRect = window.contentItem.mapFromItem(parentContainer, 0, parentContainer.height);
                return itemRect.x - (popup.implicitWidth / 2) + (parentContainer.implicitWidth / 2);
            }

            return 0;
        }
        rect.y: {
            const window = parentContainer.QsWindow.window;

            if (window?.contentItem) {
                const itemRect = window.contentItem.mapFromItem(parentContainer, 0, parentContainer.height);
                return itemRect.y;
            }
            return 0;
        }
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

    // HyprlandFocusGrab {
    //     id: grab
    //     windows: [popup.parentContainer.QsWindow.window, popup]
    //
    //     onActiveChanged: {
    //         if (!grab.active) {
    //             popup.isOpen = false;
    //         }
    //     }
    // }

    function toggle() {
        popup.isOpen = !popup.isOpen;
    }

    // Watch for state change
    onIsOpenChanged: {
        if (isOpen) {
            closeTimer.stop();
            visible = true;
            // grab.active = true;
        } else {
            closeTimer.start();
            // grab.active = false;
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
                Translate {
                    // TODO: rework animations to use behavior?
                    id: translateTransform
                    y: popup.isOpen ? 0 : -containerRect.implicitWidth

                    Behavior on y {
                        NumberAnimation {
                            duration: popup.duration
                            easing.type: Easing.InOutCubic
                        }
                    }
                },
                Scale {
                    id: scaleTransform
                    origin.x: containerRect.width / 2
                    origin.y: 0
                    // origin.y: containerRect.height / 2
                    xScale: popup.isOpen ? 1 : 0.8
                    yScale: popup.isOpen ? 1 : 0.8

                    Behavior on xScale {
                        NumberAnimation {
                            duration: popup.duration
                            // easing.type: Easing.OutBack
                            easing.type: popup.isOpen ? Easing.OutBack : Easing.InOutBack
                        }
                    }

                    Behavior on yScale {
                        NumberAnimation {
                            duration: popup.duration
                            easing.type: popup.isOpen ? Easing.OutBack : Easing.InOutBack
                        }
                    }
                }
            ]

            WrapperItem {
                id: row
                anchors.fill: parent
                anchors.margins: containerRect.margin
            }
        }
    }
}
