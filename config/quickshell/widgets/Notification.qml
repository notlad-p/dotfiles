import QtQuick
import QtQuick.Layouts

import qs.config

Rectangle {
    id: root

    // ── Notification Data ─────────────────────────────────────────────────
    required property url   appIcon
    required property string title
    required property string body
    // Milliseconds elapsed since the notification arrived
    required property int   msSinceNotification

    property bool expanded: false

    // ── Derived ───────────────────────────────────────────────────────────
    readonly property string timeSince: {
        const mins  = Math.floor(msSinceNotification / 60000);
        const hours = Math.floor(mins  / 60);
        const days  = Math.floor(hours / 24);

        if (mins  < 1) return "now";
        if (hours < 1) return `${mins}m`;
        if (days  < 1) return `${hours}h`;
        return `${days}d`;
    }

    // ── Sizing ────────────────────────────────────────────────────────────
    readonly property int padding: 14
    implicitHeight: mainRow.implicitHeight + padding * 2
                implicitWidth: 300

    // ── Appearance ────────────────────────────────────────────────────────
    // M3 surface container — slightly elevated above the panel background
    color: Qt.alpha(Colors.white, 0.05)
    radius: 12
    border.width: 1
    border.color: Qt.alpha(Colors.white, 0.08)

    // ── Layout ────────────────────────────────────────────────────────────
    RowLayout {
        id: mainRow
        anchors {
            left:        parent.left
            right:       parent.right
            top:         parent.top
            topMargin:   root.padding
            leftMargin:  root.padding
            rightMargin: root.padding
        }
        spacing: 12

        // ── App Icon ──────────────────────────────────────────────────────
        Rectangle {
            width:  40
            height: 40
            // Rounded-square shape — standard for M3 app icons
            radius: 10
            color:  Qt.alpha(Colors.white, 0.1)
            Layout.alignment: Qt.AlignTop

            Image {
                anchors {
                    fill:    parent
                    margins: 5
                }
                source:   root.appIcon
                fillMode: Image.PreserveAspectFit
                smooth:   true
            }
        }

        // ── Content Column ────────────────────────────────────────────────
        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            // Title row
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                // Title — fills all remaining horizontal space, elides if needed
                Text {
                    text: root.title
                    Layout.fillWidth: true
                    font {
                        pixelSize: 13
                        weight:    Font.DemiBold
                    }
                    color: Colors.white
                    elide: Text.ElideRight
                }

                // Relative timestamp — muted, never truncated
                Text {
                    text:            root.timeSince
                    font.pixelSize:  11
                    color:           Qt.alpha(Colors.white, 0.45)
                    Layout.alignment: Qt.AlignVCenter
                }

                // Expand / collapse chevron button
                Item {
                    implicitWidth:    22
                    implicitHeight:   22
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        id: chevron
                        anchors.centerIn: parent
                        text:            "⌄"
                        font.pixelSize:  15
                        // Dim when idle, full-white on hover
                        color: expandArea.containsMouse
                            ? Colors.white
                            : Qt.alpha(Colors.white, 0.45)
                        // Flip upward when expanded
                        rotation: root.expanded ? 180 : 0

                        Behavior on rotation {
                            NumberAnimation {
                                duration:    200
                                easing.type: Easing.OutCubic
                            }
                        }
                        Behavior on color {
                            ColorAnimation { duration: 100 }
                        }
                    }

                    MouseArea {
                        id:          expandArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape:  Qt.PointingHandCursor
                        onClicked:    root.expanded = !root.expanded
                    }
                }
            }

            // Body — single line with a trailing ellipsis, subtly muted
            Text {
                text:             root.body
                Layout.fillWidth: true
                font.pixelSize:   12
                color:            Qt.alpha(Colors.white, 0.6)
                elide:            Text.ElideRight
                maximumLineCount: 1
                // wrapMode required for maximumLineCount to take effect
                wrapMode:         Text.WordWrap
            }
        }
    }
}
