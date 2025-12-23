import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Widgets

import qs.config

StyledButton {
    id: button
    property bool connected: false

    size: "md"
    horizontalPadding: 0
    leftPadding: 8
    rightPadding: 16

    onClicked: console.log("BUTTON")

    contentItem: WrapperRectangle {
        color: "transparent"
        Row {
            spacing: 6
            IconButton {
                size: "sm"
                iconName: "wifi-4-bar"
                anchors.verticalCenter: parent.verticalCenter
                backgroundColor: button.hovered ? Qt.tint(Theme.palette._primary, Qt.alpha(Theme.palette._onPrimary, 0.08)) : Theme.palette._primary
                hoveredBackgroundColor: Qt.tint(Theme.palette._primary, Qt.alpha(Theme.palette._onPrimary, 0.18))
                textColor: Theme.palette._onPrimary

                onClicked: console.log("ICON")
            }

            // WrapperRectangle {
            //   // leftMargin: 8
            //     anchors.verticalCenter: parent.verticalCenter
            //     // color: Theme.palette._primary
            //     color: {
            //       if (toggleIconButton.hovered) {
            //         return button.hovered ? Qt.tint(Theme.palette._primary, Qt.alpha(Theme.palette._onPrimary, 0.18)) : Theme.palette._primary
            //       }
            //
            //       return button.hovered ? Qt.tint(Theme.palette._primary, Qt.alpha(Theme.palette._onPrimary, 0.08)) : Theme.palette._primary
            //     }
            //     radius: 8
            //     margin: 8
            //
            //     Behavior on color {
            //         animation: Theme.animation.expressiveDefaultEffects.color.createObject(this)
            //     }
            //
            //     HoverHandler {
            //       id: toggleIconButton
            //     }
            //
            //     TapHandler {
            //         // NOTE: this prevents propagation of tap event
            //         // https://stackoverflow.com/questions/65468040/qml-inputhandler-stop-propagation-of-event
            //         gesturePolicy: TapHandler.ReleaseWithinBounds | TapHandler.WithinBounds
            //         onTapped: console.log("ICON")
            //     }
            //
            //     Icon {
            //         iconName: "wifi-4-bar"
            //         iconColor: Theme.palette._onPrimary
            //         size: 24
            //     }
            // }

            Column {
                width: 100
                anchors.verticalCenter: parent.verticalCenter
                MaterialText {
                    text: qsTr("Wifi")
                    color: button.toggled ? Theme.palette._onPrimary : Theme.palette._onSurfaceVariant
                    font.weight: Font.Medium
                    font.letterSpacing: 0.1
                }

                MaterialText {
                    visible: button.toggled
                    text: "Home Internet"
                    color: button.toggled ? Theme.palette._onPrimary : Theme.palette._onSurfaceVariant
                    font.weight: Font.Light
                }
            }
        }
    }
}
