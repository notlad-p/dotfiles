import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import qs.config

WrapperItem {
    id: root
    topMargin: 4
    bottomMargin: 4
    default property alias content: row.data
    property color background: Colors.black700
    property color backgroundHover: Colors.black600
    property real marginX: 12
    property real marginY: 6
    property real spacing: 10
    property bool disableHover: false
    signal clicked

    Rectangle {
        id: localInfoRect
        implicitWidth: row.implicitWidth + root.marginX * 2
        implicitHeight: row.implicitHeight + root.marginY * 2
        // color: hoverHandler.hovered && !root.disableHover ? root.backgroundHover : root.background
        color: {
            if (!root.disableHover) {
                return hoverHandler.hovered && !root.disableHover ? root.backgroundHover : root.background;
            }

            return root.background;
        }
        radius: 8

        TapHandler {
            onTapped: root.clicked()
        }

        HoverHandler {
            id: hoverHandler
            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
        }

        Behavior on color {
            ColorAnimation {
                duration: 225
                easing.type: Easing.InOutQuad
            }
        }

        RowLayout {
            id: row
            spacing: root.spacing
            anchors.fill: parent
            anchors.leftMargin: root.marginX
            anchors.rightMargin: root.marginX
            anchors.topMargin: root.marginY
            anchors.bottomMargin: root.marginY
        }
    }
}
