// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.services
import qs.components
import qs.config

WrapperItem {
    id: root
    required property ShellScreen screen
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            // console.log(event.name);
            // console.log(event.data);
            if (event.name === "activespecial") {
                Hyprland.refreshWorkspaces();
            }
        // if (!event.name.endsWith("v2"))
        // root.reload();
        }
    }

    Row {
        spacing: 4

        WrapperRectangle {
            color: Colors.black700
            radius: 8

            // Behavior on implicitWidth {
            //     NumberAnimation {
            //         duration: 1000
            //         easing.type: Easing.InOutQuad
            //     }
            // }

            RowLayout {
                spacing: 2

                Repeater {
                    model: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.id === monitor.id && ws.id > 0)
                    delegate: Rectangle {
                        // required property HyprlandMonitor modelData

                        color: {
                            if (modelData.active) {
                                return hoverHandler.hovered ? Qt.alpha(Colors.blue, 0.5) : Qt.alpha(Colors.blue, 0.3);
                            }

                            return hoverHandler.hovered ? Colors.black500 : Colors.black700;
                        }
                        radius: 8
                        Layout.preferredWidth: 28
                        Layout.preferredHeight: 28

                        TapHandler {
                            onTapped: {
                                if (!modelData.active) {
                                    modelData.activate();
                                }
                            }
                        }

                        HoverHandler {
                            id: hoverHandler
                            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }

                        StyledText {
                            anchors.centerIn: parent
                            color: modelData.active ? Colors.white : Qt.alpha(Colors.white, 0.7)
                            text: modelData.name
                            pointSize: Fonts.size.xs
                            font.weight: Font.Bold

                            Behavior on color {
                                ColorAnimation {
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }
                }
            }
        }

        RowLayout {
            // Layout.fillHeight: true
            spacing: 2

            Repeater {
                model: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.id === monitor.id && ws.id < 0)
                delegate: WrapperRectangle {
                    id: specialButton
                    leftMargin: 8
                    rightMargin: 8
                    // required property HyprlandMonitor modelData
                    property string name: modelData.name.split(":")[1]
                    // Component.onCompleted: console.log(name)

                    color: {
                        if (modelData.active) {
                            return hoverHandler.hovered ? Qt.alpha(Colors.blue, 0.5) : Qt.alpha(Colors.blue, 0.3);
                        }

                        return hoverHandler.hovered ? Colors.black500 : Colors.black700;
                    }
                    radius: 8
                    // Layout.fillHeight: true
                    // Layout.fillWidth: true

                    // Layout.preferredWidth: 28
                    Layout.preferredHeight: 28

                    TapHandler {
                        onTapped: {
                            Hyprland.dispatch(`togglespecialworkspace ${name}`);
                            // if (!modelData.active) {
                            //     modelData.activate();
                            // }
                        }
                    }

                    HoverHandler {
                        id: hoverHandler
                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 250
                            easing.type: Easing.InOutQuad
                        }
                    }

                    StyledText {
                        id: specialName
                        // anchors.fill: false
                        // anchors.centerIn: parent
                        // anchors.topMargin: 6
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        color: modelData.active ? Colors.white : Qt.alpha(Colors.white, 0.7)
                        text: specialButton.name
                        pointSize: Fonts.size.xs
                        font.weight: Font.Bold

                        Behavior on color {
                            ColorAnimation {
                                duration: 250
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }
            }
        }
    }
}
