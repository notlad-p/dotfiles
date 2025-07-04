import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets

import "root:/services"

WrapperItem {
    topMargin: 4
    bottomMargin: 4

    Rectangle {
        id: localInfoRect
        property real margin: 6
        implicitWidth: row.implicitWidth + margin * 4
        implicitHeight: row.implicitHeight + margin * 2
        color: hoverHandler.hovered ? "#1f2122" : "#161819"
        radius: 8

        HoverHandler {
            id: hoverHandler
            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
        }

        Behavior on color {
            ColorAnimation {
                duration: 200
                easing.type: Easing.OutCirc
            }
        }

        RowLayout {
            id: row
            spacing: 12
            anchors.fill: parent
            anchors.leftMargin: parent.margin * 2
            anchors.rightMargin: parent.margin * 2
            anchors.topMargin: parent.margin
            anchors.bottomMargin: parent.margin

            Item {
                id: facloud
                Layout.preferredWidth: 16
                Layout.preferredHeight: 16

                Button {
                    anchors.centerIn: parent
                    background: Item {}
                    icon.source: "assets/cloud.svg"
                    icon.width: parent.implicitWidth
                    icon.height: parent.implicitHeight
                    icon.color: hoverHandler.hovered ? "#6791c9" : "#EDEFF0"
                    enabled: false

                    Behavior on icon.color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.OutCirc
                        }
                    }
                }
            }

            Text {
                text: "87°F"
                font.family: "Inter"
                font.pointSize: 9
                color: "#EDEFF0"
                font.weight: 700
                opacity: 1
                visible: true
                Layout.fillHeight: true
                renderType: TextEdit.NativeRendering
            }

            Text {
                text: Time.format("ddd, MMM d")
                font.family: "Inter"
                font.pointSize: 9
                color: "#EDEFF0"
                font.weight: 700
                opacity: 1
                visible: true
                Layout.fillHeight: true
                renderType: TextEdit.NativeRendering
            }

            Text {
                text: Time.format("h:mm ap")
                font.family: "Inter"
                font.pointSize: 9
                color: "#EDEFF0"
                font.weight: 700
                opacity: 1
                visible: true
                Layout.fillHeight: true
                renderType: TextEdit.NativeRendering
            }
        }
    }
}
