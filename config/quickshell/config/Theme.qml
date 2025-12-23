pragma Singleton

import QtQuick
import Quickshell

// Material 3 Colors
Singleton {
    id: root
    property QtObject colors
    // property QtObject animations

    // Colors are prefixed with an underscore to avoid QML naming conflicts.
    // For example, "onPrimary" is interpreted as a signal
    // materialColors: QtObject {
    property QtObject palette: QtObject {
        property color _background: "#111318"
        property color _error: "#ffb4ab"
        property color _errorContainer: "#93000a"
        property color _inverseOnSurface: "#2e3035"
        property color _inversePrimary: "#3a608f"
        property color _inverseSurface: "#e1e2e9"
        property color _onBackground: "#e1e2e9"
        property color _onError: "#690005"
        property color _onErrorContainer: "#ffdad6"
        property color _onPrimary: "#00315c"
        property color _onPrimaryContainer: "#d3e3ff"
        property color _onPrimaryFixed: "#001c39"
        property color _onPrimaryFixedVariant: "#1f4876"
        property color _onSecondary: "#263141"
        property color _onSecondaryContainer: "#d8e3f8"
        property color _onSecondaryFixed: "#111c2b"
        property color _onSecondaryFixedVariant: "#3c4758"
        property color _onSurface: "#e1e2e9"
        property color _onSurfaceVariant: "#c3c6cf"
        property color _onTertiary: "#3c2946"
        property color _onTertiaryContainer: "#f5d9ff"
        property color _onTertiaryFixed: "#261430"
        property color _onTertiaryFixedVariant: "#543f5e"
        property color _outline: "#8d9199"
        property color _outlineVariant: "#43474e"
        property color _primary: "#a4c9fe"
        property color _primaryContainer: "#1f4876"
        property color _primaryFixed: "#d3e3ff"
        property color _primaryFixedDim: "#a4c9fe"
        property color _scrim: "#000000"
        property color _secondary: "#bcc7db"
        property color _secondaryContainer: "#3c4758"
        property color _secondaryFixed: "#d8e3f8"
        property color _secondaryFixedDim: "#bcc7db"
        property color _shadow: "#000000"
        property color _surface: "#111318"
        property color _surfaceBright: "#37393e"
        property color _surfaceContainer: "#1d2024"
        property color _surfaceContainerHigh: "#272a2f"
        property color _surfaceContainerHighest: "#32353a"
        property color _surfaceContainerLow: "#191c20"
        property color _surfaceContainerLowest: "#0c0e13"
        property color _surfaceDim: "#111318"
        property color _surfaceTint: "#a4c9fe"
        property color _surfaceVariant: "#43474e"
        property color _tertiary: "#d9bde3"
        property color _tertiaryContainer: "#543f5e"
        property color _tertiaryFixed: "#f5d9ff"
        property color _tertiaryFixedDim: "#d9bde3"
    }

    // TODO: LIST:
    // - Add easings & durations here
    // - Create button container with hover & pressed
    // - Directories:
    //  - /components = reuseable components
    //  - /widgets = individual widgets that make up UI
    // - Components:
    //  - ButtonGroup
    //  - ButtonGroupButton
    //  - Button (StyledButton.qml)
    //  - ToggleButton (Icon / Text)
    //  - WidgetPopup
    // - Widgets
    //  - NotificationPopup
    //  - Notification
    //  - NotificationGroup

    property QtObject radius: QtObject {
        property int none: 0
        property int extraSmall: 4
        property int small: 8
        property int medium: 12
        property int large: 16
        property int largeIncreased: 20
        property int extraLarge: 28
        // property int full: 1000
        property var full: function (width = null, height = null) {
            let radius = 0;
            // console.log(width, height);
            if (width === null || !height) {
                radius = 1000;
            }

            if (width <= height) {
                radius = width / 2;
            } else {
                radius = height / 2;
            }

            return Math.ceil(radius);
        }
        property var fullStatic: 1000
    }

    property QtObject motion: QtObject {
      property QtObject easing: QtObject {
        readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
        readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
        readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
        readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
        readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
        readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
      }

      property QtObject duration: QtObject {
        readonly property real short1: 50
        readonly property real short2: 100
        readonly property real short3: 150
        readonly property real short4: 200
        readonly property real medium1: 250
        readonly property real medium2: 300
        readonly property real medium3: 350
        readonly property real medium4: 400
        readonly property real long1: 450
        readonly property real long2: 500
        readonly property real long3: 550
        readonly property real long4: 600
      }



        property QtObject expressiveFastSpatial: QtObject {
            readonly property real duration: 350
            readonly property list<real> bezierCurve: [0.42, 1.67, 0.21, 0.90, 1, 1]
        }
        property QtObject expressiveDefaultSpatial: QtObject {
            readonly property real duration: 500
            readonly property list<real> bezierCurve: [0.38, 1.21, 0.22, 1.00, 1, 1]
        }
        property QtObject expressiveSlowSpatial: QtObject {
            readonly property real duration: 650
            readonly property list<real> bezierCurve: [0.39, 1.29, 0.35, 0.98, 1, 1]
        }

        property QtObject expressiveDefaultEffects: QtObject {
            readonly property real duration: 200
            readonly property list<real> bezierCurve: [0.34, 0.80, 0.34, 1.00, 1, 1]
        }
    }

    // Spatial animations are used to animatie properties that move something on screen: x / y position, rotation, size, rounded corners
    // Effects animations are used to animate properties that shouldn't overshoot: color, opacity
    //
    // https://m3.material.io/styles/motion/overview/how-it-works#24ac1364-2f3e-4a52-8ba6-86f6e3830375
    property QtObject animation: QtObject {

        property QtObject expressiveFastSpatial: QtObject {
            property Component number: Component {
                NumberAnimation {
                    duration: motion.expressiveFastSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: motion.expressiveFastSpatial.bezierCurve
                }
            }
        }
        property QtObject expressiveDefaultSpatial: QtObject {
            property Component number: Component {
                NumberAnimation {
                    duration: motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: motion.expressiveDefaultSpatial.bezierCurve
                }
            }
        }
        property QtObject expressiveSlowSpatial: QtObject {
            property Component number: Component {
                NumberAnimation {
                    duration: motion.expressiveSlowSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: motion.expressiveSlowSpatial.bezierCurve
                }
            }
        }

        property QtObject expressiveDefaultEffects: QtObject {
            property Component number: Component {
                NumberAnimation {
                    duration: motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: motion.expressiveDefaultEffects.bezierCurve
                }
            }
            property Component color: Component {
                ColorAnimation {
                    duration: motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: motion.expressiveDefaultEffects.bezierCurve
                }
            }
        }
    }
}
