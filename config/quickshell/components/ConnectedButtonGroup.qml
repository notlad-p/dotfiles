import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

ClippingWrapperRectangle {
    id: root
    color: "transparent"
    radius: Theme.radius.full(root.implicitWidth, root.implicitHeight)
    default property alias content: buttonRow.children
    RowLayout {
        id: buttonRow
        spacing: 2
    }
}
