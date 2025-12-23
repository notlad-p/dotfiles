import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell
import Quickshell.Widgets

import qs.components
import qs.config

// TODO: middle click to screenshot this screen
// TODO: change icon when recording
BarButton {
    id: root
    marginX: 6
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    Icon {
        id: icon
        size: 16
        iconColor: Colors.white
        iconName: "screenshot"
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            TapHandler {
                onTapped: parent.forceActiveFocus()
            }

            ColumnLayout {
                spacing: 12

                Item {
                    Layout.fillWidth: true
                    Layout.topMargin: 12
                    Layout.bottomMargin: 12

                    WrapperRectangle {
                        margin: 5
                        anchors.verticalCenter: parent.verticalCenter
                        radius: 6
                        color: "transparent"

                        Icon {
                            iconName: "settings"
                        }
                    }

                    WrapperRectangle {
                        color: Colors.black800
                        radius: 6
                        anchors.centerIn: parent

                        Row {

                            WrapperRectangle {
                                radius: 6
                                topMargin: 5
                                bottomMargin: 5
                                leftMargin: 11
                                rightMargin: 11
                                color: Colors.black500
                                Icon {
                                    iconName: "camera"
                                }
                            }

                            WrapperRectangle {
                                radius: 6
                                topMargin: 5
                                bottomMargin: 5
                                leftMargin: 11
                                rightMargin: 11
                                color: Colors.black700
                                Icon {
                                    iconName: "video"
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    spacing: 8

                    Rectangle {
                        color: Colors.blue
                        radius: 8
                        implicitWidth: 116
                        implicitHeight: 32

                        Row {
                            spacing: 8
                            anchors.centerIn: parent
                            Icon {
                                iconName: "screenshot"
                                iconColor: Colors.black700
                            }

                            StyledText {
                                text: "Area"
                                font.weight: Font.DemiBold
                                color: Colors.black700
                            }
                        }
                    }

                    Rectangle {
                        color: Colors.black700
                        radius: 8
                        implicitWidth: 116
                        implicitHeight: 32

                        Row {
                            spacing: 8
                            anchors.centerIn: parent
                            Icon {
                                iconName: "monitor"
                            }
                            StyledText {
                                text: "Monitor"
                                font.weight: Font.DemiBold
                            }
                        }
                    }

                    Rectangle {
                        color: Colors.black700
                        radius: 8
                        implicitWidth: 116
                        implicitHeight: 32

                        Row {
                            spacing: 8
                            anchors.centerIn: parent
                            Icon {
                                iconName: "rectangle-stack"
                            }
                            StyledText {
                                text: "All"
                                font.weight: Font.DemiBold
                            }
                        }
                    }
                }

                RowLayout {
                    // TODO: on click focus input
                    WrapperRectangle {
                        implicitHeight: 32
                        // topPadding: 8
                        // bottomPadding: 8
                        leftMargin: 12
                        rightMargin: 12
                        color: Colors.black700
                        radius: 8
                        Layout.fillWidth: true

                        RowLayout {
                            spacing: 8
                            Icon {
                                iconName: "folder"
                                size: 16
                            }

                            TextField {
                                placeholderText: qsTr("~/Pictures")
                                placeholderTextColor: Qt.alpha(Colors.white, 0.4)
                                font.weight: Font.Medium
                                color: Colors.white
                                Layout.fillWidth: true
                                // implicitHeight: 32
                                // topPadding: 8
                                // bottomPadding: 8
                                // leftPadding: 12
                                // rightPadding: 12

                                background: Rectangle {
                                    color: "transparent"
                                }
                            }

                            Icon {
                                iconName: "caret-small-down"
                                iconColor: Colors.white
                                opacity: 0.6
                                size: 16
                            }
                        }
                    }

                    WrapperRectangle {
                        implicitHeight: 32
                        leftMargin: 12
                        rightMargin: 12
                        color: Colors.black700
                        radius: 8

                        RowLayout {
                            spacing: 8
                            Icon {
                                iconName: "clock-countdown"
                                size: 18
                            }

                            // TODO: change this to a ComboBox
                            TextField {
                                placeholderText: qsTr("0s")
                                placeholderTextColor: Qt.alpha(Colors.white, 0.4)
                                font.weight: Font.Medium
                                color: Colors.white
                                Layout.fillWidth: true

                                background: Rectangle {
                                    color: "transparent"
                                }
                            }
                        }
                    }
                }

                WrapperRectangle {
                    margin: 4
                    color: "transparent"
                    border.width: 3
                    border.color: Colors.white
                    radius: 100
                    Layout.topMargin: 4
                    Layout.alignment: Qt.AlignHCenter
                    // anchors.topMargin: 8
                    // anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        color: captureButtonTap.pressed ? Qt.alpha(Colors.white, 0.8) : Colors.white
                        radius: 32
                        implicitHeight: 32
                        implicitWidth: 32

                        transform: Scale {
                            origin.x: 16
                            origin.y: 16
                            xScale: captureButtonTap.pressed ? 0.92 : 1
                            yScale: captureButtonTap.pressed ? 0.92 : 1

                            Behavior on xScale {
                                NumberAnimation {
                                    duration: 50
                                }
                            }

                            Behavior on yScale {
                                NumberAnimation {
                                    duration: 50
                                }
                            }
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 50
                            }
                        }
                    }

                    TapHandler {
                        id: captureButtonTap
                    }

                    HoverHandler {
                        id: captureButtonHover

                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }
                }
            }
        }
    }
}
