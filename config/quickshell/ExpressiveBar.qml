import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import qs.services
import qs.widgets
import qs.config
import qs.components
import qs.widgets.bar

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData
            color: "transparent"

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: containerRect.implicitHeight

            Rectangle {
                id: containerRect
                property real verticalMargin: Theme.spacing(1.5)
                property real horizontalMargin: Theme.spacing(4)
                anchors.fill: parent
                implicitHeight: itemsContainer.implicitHeight + containerRect.verticalMargin * 2
                // radius: 8
                color: Theme.palette._background

                Item {
                    id: itemsContainer
                    anchors.fill: containerRect
                    implicitWidth: parent.implicitWidth
                    implicitHeight: Math.max(left.implicitHeight, center.implicitHeight, right.implicitHeight)
                    anchors.topMargin: containerRect.verticalMargin
                    anchors.leftMargin: containerRect.horizontalMargin
                    anchors.rightMargin: containerRect.horizontalMargin

                    RowLayout {
                        id: left
                        anchors.left: parent.left
                        spacing: 6

                        IconButton {
                            id: archIconButton
                            iconName: "arch"
                            textColor: Theme.palette._primary
                            size: "xs"
                            implicitWidth: 46
                            buttonWidth: "wide"
                            roundedLeft: true
                            radius: 8
                            onClicked: archIconButton.toggled = !archIconButton.toggled
                        }

                        Workspaces {
                            screen: modelData
                        }
                    }

                    RowLayout {
                        id: center
                        spacing: 6
                        anchors.horizontalCenter: parent.horizontalCenter

                        StyledButton {
                            id: dateTimeButton
                            text: Time.format("ddd, MMM d  h:mm ap")
                            size: "xs"
                            roundedLeft: true
                            radius: 8
                            onClicked: dateTimeButton.toggled = !dateTimeButton.toggled
                        }

                        StyledButton {
                            id: weatherButton
                            text: "73°"
                            size: "xs"
                            iconName: "weather-cloudy"
                            radius: 8
                            onClicked: weatherButton.toggled = !weatherButton.toggled
                        }

                        IconButton {
                            id: notificationsIconButton
                            iconName: "material/notifications"
                            size: "xs"
                            // rawIcon: true
                            implicitWidth: 44
                            buttonWidth: "wide"
                            roundedRight: true
                            radius: 8
                            onClicked: notificationsIconButton.toggled = !notificationsIconButton.toggled
                        }
                    }

                    RowLayout {
                        id: right
                        anchors.right: parent.right
                        spacing: 8

                        Text {
                            text: "right"
                        }
                    }
                }
            }
        }
    }
}
