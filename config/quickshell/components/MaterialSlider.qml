import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

Slider {
    id: root

    property string size: "sm"
    property string iconName
    property string inactiveIconName
    property real trackOutsideRadius: {
        switch (root.size) {
        case "xs":
        case "sm":
            return 8;
        case "md":
            return 12;
        case "lg":
            return 16;
        case "xl":
            return 28;
        default:
            return 8;
        }
    }
    property real actualVisualPosition: visualPosition
    property bool animationTriggered: false
    property bool moveAnimationRunning: false

    Layout.fillWidth: true
    implicitWidth: 200
    implicitHeight: handle.height
    value: 50
    from: 0
    to: 100

    onPressedChanged: {
      if (root.pressed) {
        console.log("play animation to value once, then bind position to actual position")
        visBeh.enabled = true
      } else {
        console.log("unbind actual position?")
        // console.log("don't play animation")
      }
    }

    MouseArea {
        anchors.fill: parent
        onPressed: (mouse) => mouse.accepted = false
        cursorShape: root.pressed ? Qt.ClosedHandCursor : Qt.PointingHandCursor 
    }

    Behavior on actualVisualPosition {
        id: visBeh
        // enabled: !animationTriggered
        enabled: false
        // NumberAnimation {
        SmoothedAnimation {
            id: visAnim
            velocity: -1
            duration: Theme.motion.duration.medium2
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Theme.motion.easing.emphasizedAccel
            onRunningChanged: {
                root.moveAnimationRunning = visAnim.running;
                console.log(visAnim.running);
                if (!visAnim.running) {
                  visBeh.enabled = false
                }
                // console.log(visAnim.running);
                // if (visAnim.running)
            }
        }
    }

    // when pressed & dragging, don't animate
    // when pressed on position value that isn't the same, animate
    // states: State {
    //     name: "moved"
    //     // when: Math.abs(root.actualVisualPosition - root.visualPosition) >= 0.1
    //     when: root.pressed
    //     PropertyChanges {
    //         target: root
    //         actualVisualPosition: root.visualPosition
    //     }
    // }
    //
    // transitions: Transition {
    //     SmoothedAnimation {
    //         id: visAnim
    //         properties: "actualVisualPosition"
    //         velocity: -1
    //         duration: Theme.motion.duration.medium2
    //         easing.type: Easing.BezierSpline
    //         easing.bezierCurve: Theme.motion.easing.emphasizedAccel
    //         onRunningChanged: {
    //             root.moveAnimationRunning = visAnim.running;
    //             console.log(visAnim.running);
    //         }
    //     }
    // }

    background: Rectangle {
        id: backgroundContainer
        x: root.leftPadding
        y: root.topPadding + root.availableHeight / 2 - height / 2
        implicitWidth: 200
        implicitHeight: {
            switch (root.size) {
            case "xs":
                return 16;
            case "sm":
                return 24;
            case "md":
                return 40;
            case "lg":
                return 56;
            case "xl":
                return 96;
            default:
                return 24;
            }
        }
        width: root.availableWidth
        height: implicitHeight
        radius: 2
        color: "transparent"

        ClippingWrapperRectangle {
            anchors.fill: parent
            topLeftRadius: trackOutsideRadius
            bottomLeftRadius: trackOutsideRadius
            color: "transparent"

            Item {
                implicitWidth: root.implicitWidth
                implicitHeight: root.implicitHeight

                Rectangle {
                    id: activeTrack
                    z: 1
                    width: root.actualVisualPosition * parent.width - (handle.width + 6)
                    height: parent.height
                    color: Theme.palette._primary
                    radius: 2
                }
            }
        }

        ClippingWrapperRectangle {
            anchors.fill: parent
            topRightRadius: trackOutsideRadius
            bottomRightRadius: trackOutsideRadius
            color: "transparent"

            Item {
                implicitWidth: root.implicitWidth
                implicitHeight: root.implicitHeight

                Rectangle {
                    anchors.right: parent.right
                    width: (root.actualVisualPosition * parent.width - (parent.width - (handle.width + 6))) * -1
                    height: parent.height
                    color: Theme.palette._secondaryContainer
                    opacity: 0.3
                    radius: 2
                }
            }
        }

        Rectangle {
            id: handle
            z: 1
            width: {
                if (root.pressed || root.moveAnimationRunning) {
                    return 2;
                }
                return 4;
            }
            height: {
                switch (root.size) {
                case "xs":
                case "sm":
                    return 44;
                case "md":
                    return 52;
                case "lg":
                    return 68;
                case "xl":
                    return 108;
                default:
                    return 44;
                }
            }
            color: Theme.palette._primary
            x: root.actualVisualPosition * parent.width - (handle.width / 2)
            anchors.verticalCenter: parent.verticalCenter

            Behavior on width {
                animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
            }
        }

        WrapperRectangle {
            // anchors.bottom: handle.top
            // anchors.horizontalCenter: handle.horizontalCenter
            id: valueIndicator
            x: root.actualVisualPosition * parent.width - (valueIndicator.width / 2)
            // y: {
            //   return root.pressed ? 0 : -16
            // }
            anchors.bottom: handle.top
            anchors.bottomMargin: 4
            color: Theme.palette._inverseSurface
            topMargin: 12
            bottomMargin: 12
            leftMargin: 16
            rightMargin: 16
            radius: Theme.radius.full(width, height)

            states: State {
                name: "visible"
                when: root.pressed || root.moveAnimationRunning
                PropertyChanges {
                    target: scaleTransform
                    xScale: 1
                    yScale: 1
                }
            }

            transitions: [
                Transition {
                    from: ""
                    to: "visible"
                    NumberAnimation {
                        properties: "xScale,yScale"
                        easing.type: Easing.InOutQuad
                    }
                },
                Transition {
                    from: "visible"
                    to: ""

                    SequentialAnimation {
                        PauseAnimation {
                            duration: Theme.motion.duration.medium2
                        }
                        NumberAnimation {
                            properties: "xScale,yScale"
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            ]

            transform: Scale {
                id: scaleTransform
                origin.x: valueIndicator.width / 2
                origin.y: valueIndicator.height
                xScale: 0
                yScale: 0
            }

            MaterialText {
                text: Math.round(root.actualVisualPosition * root.to)
                color: Theme.palette._inverseOnSurface
            }
        }

        Rectangle {
            visible: root.position < 0.96
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 6
            width: 4
            height: 4
            radius: 2
        }

        Loader {
            active: root.iconName
            visible: root.iconName
            opacity: root.actualVisualPosition <= 0.25 ? root.actualVisualPosition / 0.25 : 1
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 6
            sourceComponent: Component {
              Icon {
                  size: 24
                  iconColor: Theme.palette._onPrimary
                  iconName: root.iconName
              }
            }
        }

        Loader {
            active: root.inactiveIconName
            visible: root.inactiveIconName
            opacity: root.actualVisualPosition === 0 ? 1 : 0
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 16
            sourceComponent: Component {
              Icon {
                  size: 24
                  iconColor: Theme.palette._onSecondaryContainer
                  iconName: root.inactiveIconName

              }
            }

            Behavior on opacity {
                animation: Theme.animation.expressiveDefaultEffects.number.createObject(this)
            }
        }
    }

    handle: Item {}
}
