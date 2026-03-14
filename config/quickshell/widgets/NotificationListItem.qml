import QtQuick
import QtQuick.Layouts

import qs.config
import qs.components

Rectangle {
    id: root

    // ── Notification Data ─────────────────────────────────────────────────
    required property url appIcon
    required property string appName
    required property string title
    required property string body
    // Unix timestamp in ms when the notification arrived — use Date.now()
    required property real timestamp

    property bool expanded: false

    // ── Live Clock ────────────────────────────────────────────────────────
    property real currentTime: Date.now()

    Timer {
        interval: 60000
        running: true
        repeat: true
        onTriggered: root.currentTime = Date.now()
    }

    // ── Time Since ────────────────────────────────────────────────────────
    readonly property string timeSince: {
        const ms = root.currentTime - root.timestamp;
        const mins = Math.floor(ms / 60000);
        const hours = Math.floor(mins / 60);
        const days = Math.floor(hours / 24);

        if (mins < 1)
            return "now";
        if (hours < 1)
            return `${mins}m`;
        if (days < 1)
            return `${hours}h`;
        return `${days}d`;
    }

    // ── Sizing ────────────────────────────────────────────────────────────
    readonly property int pad: 14
    implicitWidth: 400
    implicitHeight: contentRow.implicitHeight + pad * 2

    // ── Appearance ────────────────────────────────────────────────────────
    color: Qt.alpha(Colors.white, 0.05)
    radius: 12
    border.width: 1
    border.color: Qt.alpha(Colors.white, 0.08)

    // ── Helpers ───────────────────────────────────────────────────────────
    // Max width the label / title can occupy in the header row
    readonly property real maxLabelWidth: contentRow.width - 40 - 12 - 60 - 40
    // Stable collapsed width so the title & slot start from the same value
    readonly property real titleCollapsedWidth: Math.min(titleText.implicitWidth, maxLabelWidth)

    // ── Layout ────────────────────────────────────────────────────────────
    RowLayout {
        id: contentRow
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: root.pad
            leftMargin: root.pad
            rightMargin: root.pad
        }
        spacing: 12

        // ── App Icon ──────────────────────────────────────────────────────
        Rectangle {
            width: 40
            height: 40
            radius: width / 2
            color: Qt.alpha(Colors.white, 0.1)
            Layout.alignment: Qt.AlignTop

            Image {
                anchors {
                    fill: parent
                    margins: 5
                }
                source: root.appIcon
                fillMode: Image.PreserveAspectFit
                smooth: true
            }
        }

        // ── Content Area — hosts the layout column + floating title ───────
        Item {
            id: contentArea
            Layout.fillWidth: true
            implicitHeight: contentColumn.implicitHeight

            // ── Layout Column ─────────────────────────────────────────────
            ColumnLayout {
                id: contentColumn
                anchors {
                    left: parent.left
                    right: parent.right
                    top: parent.top
                }
                spacing: 0

                // ── Header Row ────────────────────────────────────────────
                RowLayout {
                    id: headerRow
                    Layout.fillWidth: true
                    spacing: 0

                    // Label slot — reserves title width when collapsed,
                    //               shows app name when expanded
                    Item {
                        id: labelSlot
                        Layout.maximumWidth: root.maxLabelWidth
                        implicitWidth: root.expanded
                            ? headerAppName.implicitWidth
                            : root.titleCollapsedWidth
                        implicitHeight: headerAppName.implicitHeight

                        Behavior on implicitWidth {
                            NumberAnimation {
                                duration: 250
                                easing.type: Easing.OutCubic
                            }
                        }

                        // App name — fades in when expanded
                        Text {
                            id: headerAppName
                            width: labelSlot.width
                            anchors.verticalCenter: parent.verticalCenter
                            text: root.appName
                            font.pixelSize: 11
                            color: Qt.alpha(Colors.white, 0.45)
                            elide: Text.ElideRight
                            opacity: root.expanded ? 1 : 0

                            Behavior on opacity {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }
                    }

                    // Dot separator
                    Rectangle {
                        width: 3
                        height: 3
                        radius: 1.5
                        color: Qt.alpha(Colors.white, 0.45)
                        Layout.alignment: Qt.AlignVCenter
                        Layout.leftMargin: 5
                        Layout.rightMargin: 5
                    }

                    // Relative timestamp
                    Text {
                        text: root.timeSince
                        font.pixelSize: 11
                        color: Qt.alpha(Colors.white, 0.45)
                        Layout.alignment: Qt.AlignVCenter
                    }

                    // Spacer to push chevron to the right
                    Item {
                        Layout.fillWidth: true
                    }

                    // ── Chevron Button ────────────────────────────────────
                    Rectangle {
                        implicitWidth: 32
                        implicitHeight: 24
                        radius: 12
                        color: chevronArea.containsMouse
                            ? Qt.alpha(Colors.white, 0.15)
                            : Qt.alpha(Colors.white, 0.08)
                        Layout.alignment: Qt.AlignVCenter

                        Behavior on color {
                            ColorAnimation {
                                duration: 100
                            }
                        }

                        Icon {
                            anchors.centerIn: parent
                            size: 16
                            raw: true
                            iconName: "chevron"
                            rotation: root.expanded ? 180 : 0

                            Behavior on rotation {
                                NumberAnimation {
                                    duration: 200
                                    easing.type: Easing.OutCubic
                                }
                            }
                        }

                        MouseArea {
                            id: chevronArea
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.expanded = !root.expanded
                        }
                    }
                }

                // ── Title Spacer — reserves vertical room for the title
                //    when it slides down into the content area ─────────────
                Item {
                    Layout.fillWidth: true
                    Layout.preferredHeight: root.expanded
                        ? titleText.implicitHeight + 4
                        : 0

                    Behavior on Layout.preferredHeight {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                // ── Body Text ─────────────────────────────────────────────
                Item {
                    Layout.fillWidth: true
                    Layout.topMargin: 4
                    Layout.preferredHeight: root.expanded
                        ? bodyFull.implicitHeight
                        : bodyCollapsed.implicitHeight
                    clip: true

                    Behavior on Layout.preferredHeight {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutCubic
                        }
                    }

                    // Collapsed: single line with ellipsis
                    Text {
                        id: bodyCollapsed
                        anchors.top: parent.top
                        width: parent.width
                        text: root.body
                        font.pixelSize: 12
                        color: Qt.alpha(Colors.white, 0.6)
                        wrapMode: Text.WordWrap
                        maximumLineCount: 1
                        elide: Text.ElideRight
                        opacity: root.expanded ? 0 : 1

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }

                    // Expanded: full body
                    Text {
                        id: bodyFull
                        anchors.top: parent.top
                        width: parent.width
                        text: root.body
                        font.pixelSize: 12
                        color: Qt.alpha(Colors.white, 0.6)
                        wrapMode: Text.WordWrap
                        opacity: root.expanded ? 1 : 0

                        Behavior on opacity {
                            NumberAnimation {
                                duration: 150
                            }
                        }
                    }
                }
            }

            // ── Floating Title ────────────────────────────────────────────
            // A single Text that lives outside the layout flow and
            // physically slides between the header row and the content area.
            Text {
                id: titleText

                x: 0
                y: root.expanded
                    ? headerRow.height + 4
                    : (headerRow.height - implicitHeight) / 2

                width: root.expanded
                    ? contentArea.width
                    : root.titleCollapsedWidth   // ← stable value, not labelSlot.width

                text: root.title
                // TODO: copy body text implementation for long text in title that should be wrapped when expanded
                // wrapMode: root.expanded ? Text.WordWrap : Text.NoWrap
                font {
                    pixelSize: 13
                    weight: Font.DemiBold
                }
                color: Colors.white
                elide: Text.ElideRight

                Behavior on y {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on width {
                    NumberAnimation {
                        duration: 250
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on height {
                    NumberAnimation {
                        duration: 10000
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }
    }
}
