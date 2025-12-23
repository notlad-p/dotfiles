import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.VectorImage
import QtQuick.Effects

import qs.config

Item {
    id: root
    required property string iconName
    property color iconColor: Colors.white
    property real size: 16
    property bool raw: false
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    IconImage {
        id: icon
        visible: root.raw
        source: "root:/assets/" + root.iconName + ".svg"
        implicitSize: root.size
    }

    MultiEffect {
        enabled: !root.raw
        visible: !root.raw
        source: icon
        anchors.fill: icon
        colorization: 1.0
        colorizationColor: root.iconColor

        Behavior on colorizationColor {
            animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
        }
    }
}
