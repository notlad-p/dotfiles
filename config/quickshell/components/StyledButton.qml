import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Widgets

import qs.config

Button {
    id: root
    // Values: "xs", "sm", "md", "lg", "xl"
    property string size: "sm"
    property bool toggled: false
    // TODO: change this to star
    property string iconName
    property int iconSize
    property bool rawIcon: false
    property bool quantizeIconBackground: false

    // ── Colors ───────────────────────────────────────────────────────

    property color backgroundColor: Theme.palette._surfaceContainer
    property color toggledBackgroundColor: Theme.palette._primary

    property color textColor: Theme.palette._onSurfaceVariant
    property color toggledTextColor: Theme.palette._onPrimary

    property color hoveredBackgroundColor: Qt.tint(backgroundColor, Qt.alpha(textColor, 0.08))

    property color toggledHoveredBackgroundColor: Qt.tint(toggledBackgroundColor, Qt.alpha(toggledTextColor, 0.08))

    /// The text/icon color currently in effect.
    readonly property color contentColor: toggled ? toggledTextColor : textColor

    // ── Border ───────────────────────────────────────────────────────

    property color borderColor: "transparent"
    property int borderWidth: 0

    // ── Geometry ─────────────────────────────────────────────────────

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
    property bool roundedLeft: false
    property bool roundedRight: false
    property real toggledRadius: {
        if (root.rounded) {
            return determineRadius();
        }

        return Theme.radius.full(width, height);
    }

    property real radius: {
        if (root.rounded) {
            return Theme.radius.full(width, height);
        }

        return determineRadius();
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
                    iconColor: root.contentColor
                    iconName: root.iconName
                    raw: root.rawIcon

                    Loader {
                        Layout.alignment: Qt.AlignHCenter
                        active: root.quantizeIconBackground
                        sourceComponent: ColorQuantizer {
                            id: colorQuantizer
                            source: Qt.resolvedUrl("root:/assets/" + root.iconName + ".svg")
                            depth: 1
                            rescaleSize: 20
                            onColorsChanged: {
                                root.textColor = colors[1];
                                root.toggledTextColor = colors[1];
                                root.backgroundColor = Qt.alpha(colors[1], 0.20); 
                                root.toggledBackgroundColor = Qt.alpha(colors[1], 0.30);
                            }
                        }
                    }
                }
            }
        }

        Loader {
            Layout.alignment: Qt.AlignHCenter
            active: root.text
            visible: root.text
            sourceComponent: Component {
                StyledText {
                    visible: root.text
                    text: qsTr(root.text)
                    color: root.contentColor
                    grade: root.toggled && 100
                    role: {
                        switch (root.size) {
                        case "xs":
                        case "sm":
                            return "labelLarge";
                        case "md":
                            return "titleMedium";
                        case "lg":
                            return "headlineSmall";
                        case "xl":
                            return "headlineLarge";
                        default:
                            return 14;
                        }
                    }

                    Behavior on color {
                        animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
                    }
                }
            }
        }
    }

    background: ClippingRectangle {
        color: root.toggled ? root.toggledBackgroundColor : root.backgroundColor

        border.color: root.borderColor
        border.width: root.borderWidth

        radius: {
            if (root.down) {
                return root.pressedRadius;
            }

            return root.toggled ? root.toggledRadius : root.radius;
        }

        bottomLeftRadius: {
            if (root.roundedLeft) {
                if (root.down) {
                    return root.pressedRadius;
                }

                return Theme.radius.full(root.width, root.height);
            }
        }
        topLeftRadius: {
            if (root.roundedLeft) {
                if (root.down) {
                    return root.pressedRadius;
                }

                return Theme.radius.full(root.width, root.height);
            }
        }

        bottomRightRadius: {
            if (root.roundedRight) {
                if (root.down) {
                    return root.pressedRadius;
                }

                return Theme.radius.full(root.width, root.height);
            }
        }
        topRightRadius: {
            if (root.roundedRight) {
                if (root.down) {
                    return root.pressedRadius;
                }

                return Theme.radius.full(root.width, root.height);
            }
        }

        // State Layer
        Rectangle {
            id: stateLayer
            anchors.fill: parent
            color: root.contentColor 
            opacity: {
                if (root.pressed) return 0.10;
                if (buttonHover.hovered) return 0.08;
                return 0.0;
            }

            Behavior on opacity {
                animation: Theme.animation.expressiveDefaultEffects.number.createObject(this)
            }
        }

        Behavior on color {
            animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
        }

        Behavior on border.color {
            animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
        }

        Behavior on radius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }

        Behavior on topLeftRadius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }

        Behavior on bottomLeftRadius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }

        Behavior on topRightRadius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }

        Behavior on bottomRightRadius {
            animation: Theme.animation.expressiveFastSpatial.number.createObject(this)
        }
    }
}
