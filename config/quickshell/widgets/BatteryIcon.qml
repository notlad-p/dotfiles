import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.VectorImage
import QtQuick.Effects

import qs.config

Item {
    id: root
    required property real percentage
    property string iconName: "battery"
    property color iconColor: Colors.white
    property real size: 16
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    IconImage {
        id: icon
        visible: false
        source: "root:/assets/" + root.iconName + ".svg"
        implicitSize: root.size
    }

    Item {
        id: maskRectangle
        width: icon.width
        height: icon.height
        visible: false
        layer.enabled: true

        Rectangle {
            color: Colors.red
            width: parent.width * root.percentage
            height: parent.height
            x: 0
        }
    }

    // under side of icon
    IconImage {
        visible: true
        opacity: 0.6
        source: "root:/assets/" + root.iconName + ".svg"
        implicitSize: root.size
    }

    MultiEffect {
        source: icon
        anchors.fill: icon
        colorization: 1.0
        colorizationColor: root.iconColor
        // mask
        maskEnabled: true
        maskSource: maskRectangle

        Behavior on colorizationColor {
            animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
        }
    }

    // Item {
    //     width: icon.width
    //     height: icon.height
    //     anchors.leftMargin: 10
    //     // anchors.centerIn: parent
    //
    //     Text {
    //         anchors.verticalCenter: parent.verticalCenter
    //         // anchors.centerIn: parent
    //         text: `${Math.round(root.percentage * 100)}%`
    //         // minimumPointSize: 10
    //         // font.pointSize: 6
    //         font.pixelSize: 10
    //         font.weight: 800
    //         fontSizeMode: Text.Fit
    //         color: 'black'
    //     }
    // }
}
