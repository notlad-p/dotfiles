import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Widgets

import qs.config

// toggled
// enabled / disabled

Button {
    id: root
    // Values: "xs", "sm", "md", "lg", "xl"
    property string size: "sm"
    property bool toggled: false
    // TODO: change this to star
    property string iconName
    property int iconSize
    property color backgroundColor: toggled ? Theme.palette._primary : Theme.palette._surfaceContainer
    property color hoveredBackgroundColor:  toggled ? Qt.tint(Theme.palette._primary, Qt.alpha(Theme.palette._onPrimary, 0.08)) : Qt.tint(Theme.palette._surfaceContainer, Qt.alpha(root.textColor, 0.08))
    property color textColor: toggled ? Theme.palette._onPrimary : Theme.palette._onSurfaceVariant

    horizontalPadding: {
        switch (root.size) {
        case "xs":
            return 12;
        case "sm":
            return 16;
        case "md":
            return 24;
        case "lg":
            return 48;
        case "xl":
            return 64;
        default:
            return 16;
        }
    }

    function determineRadius() {
        switch (root.size) {
        case "xs":
        case "sm":
            return Theme.radius.medium;
        case "md":
            return Theme.radius.large;
        case "lg":
        case "xl":
            return Theme.radius.extraLarge;
        default:
            return Theme.radius.medium;
        }
    }

    property bool rounded: false
    property real toggledRadius: {
        if (root.rounded) {
            return determineRadius()
        }

        return Theme.radius.full(width, height);
    }

    property real radius: {
      if (root.rounded) {
        return Theme.radius.full(width, height);
      }

      return determineRadius()
    }

    property real pressedRadius: {
        switch (root.size) {
        case "xs":
        case "sm":
            return Theme.radius.small;
        case "md":
            return Theme.radius.medium;
        case "lg":
        case "xl":
            return Theme.radius.large;
        default:
            return Theme.radius.small;
        }
    }

    implicitHeight: {
        switch (root.size) {
        case "xs":
            return 32;
        case "sm":
            return 40;
        case "md":
            return 56;
        case "lg":
            return 96;
        case "xl":
            return 136;
        default:
            return 40;
        }
    }
    // anchors.horizontalCenter: parent.horizontalCenter

    HoverHandler {
        id: buttonHover
        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
    }

    Behavior on width {
        animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
    }

    contentItem: RowLayout {
        spacing: {
            switch (root.size) {
            case "xs":
                return 4;
            case "sm":
            case "md":
                return 8;
            case "lg":
                return 12;
            case "xl":
                return 16;
            default:
                return Theme.radius.medium;
            }
        }

        Loader {
            Layout.alignment: Qt.AlignHCenter
            active: root.iconName
            visible: root.iconName
            sourceComponent: Component {
                Icon {
                    size: {
                        if (root.iconSize) {
                            return root.iconSize;
                        }

                        switch (root.size) {
                        case "xs":
                        case "sm":
                            return 20;
                        case "md":
                            return 24;
                        case "lg":
                            return 32;
                        case "xl":
                            return 40;
                        default:
                            return 20;
                        }
                    }
                    iconColor: root.textColor
                    iconName: root.iconName
                }
            }
        }

        Loader {
            Layout.alignment: Qt.AlignHCenter
            active: root.text
            visible: root.text
            sourceComponent: Component {
                MaterialText {
                    visible: root.text
                    text: qsTr(root.text)
                    color: root.textColor
                    font.weight: Font.Medium
                    font.pixelSize: {
                        switch (root.size) {
                        case "xs":
                        case "sm":
                            return 14;
                        case "md":
                            return 16;
                        case "lg":
                            return 24;
                        case "xl":
                            return 32;
                        default:
                            return 14;
                        }
                    }
                    font.letterSpacing: {
                        switch (root.size) {
                        case "xs":
                        case "sm":
                            return 0.1;
                        case "md":
                            return 0.15;
                        case "lg":
                        case "xl":
                            return 0;
                        default:
                            return 0.1;
                        }
                    }

                  Behavior on color {
                      animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
                  }
                }
            }
        }
    }

    background: Rectangle {
        color: buttonHover.hovered ? root.hoveredBackgroundColor : root.backgroundColor
        // radius: root.pressed ? root.pressedRadius : root.radius
        radius: {
          if (root.down) {
            return root.pressedRadius
          }

          return root.toggled ? root.toggledRadius : root.radius
        }

        Behavior on color {
            animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
        }

        Behavior on radius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }
    }
}
