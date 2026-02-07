import QtQuick
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.VectorImage
import QtQuick.Effects

import qs.config

Item {
    id: root
    required property real percentage
    property color iconColor: Colors.white
    property real size: 16
    property bool raw: false
    implicitHeight: icon.implicitHeight
    implicitWidth: icon.implicitWidth

    IconImage {
        id: icon
        visible: false
        source: "root:/assets/battery-charging-body.svg"
        implicitSize: root.size
    }

    Item {
        id: maskRectangle
        width: icon.width
        height: icon.height
        visible: false
        layer.enabled: true

        Rectangle {
            width: parent.width * 0.85 * root.percentage
            height: parent.height
            x: 0
        }
    }

    // underside body of icon
    IconImage {
        visible: true
        opacity: 0.6
        source: "root:/assets/battery-charging-body.svg"
        implicitSize: root.size
    }

    // charging symbol
    IconImage {
        id: chargingIcon
        visible: true
        source: "root:/assets/battery-charging-symbol.svg"
        implicitSize: root.size
    }

    MultiEffect {
        source: icon
        anchors.fill: icon
        colorization: 1.0
        colorizationColor: Colors.green
        // mask
        maskEnabled: true
        maskSource: maskRectangle
        maskThresholdMin: 0.0

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
    //       x: parent.width * 0.05
    //         anchors.verticalCenter: parent.verticalCenter
    //         // anchors.centerIn: parent
    //         text: `${Math.round(root.percentage * 100)}`
    //         // minimumPointSize: 10
    //         // font.pointSize: 6
    //         font.pixelSize: parent.width * 0.5
    //         font.weight: 900
    //         fontSizeMode: Text.Fit
    //         color: 'black'
    //     }
    // }
}
