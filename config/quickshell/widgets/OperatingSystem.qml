import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import Quickshell.Widgets

import qs.components
import qs.config
import qs.services

BarButton {
    id: root
    background: Colors.blue
    backgroundHover: Qt.lighter(Colors.blue, 1.25)
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
        iconColor: Colors.black900
        iconName: "arch"
    }

    PowerPopup {
        id: powerPopup
        parentContainer: root
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {
                spacing: 12

                WrapperRectangle {
                    color: Colors.black800
                    margin: 12
                    radius: 8
                    Layout.minimumWidth: 320

                    RowLayout {

                        ClippingWrapperRectangle {
                            color: "transparent"
                            radius: 64
                            Layout.preferredWidth: 64
                            Layout.preferredHeight: 64

                            Image {
                                sourceSize.width: parent.width
                                sourceSize.height: parent.height
                                source: `${Quickshell.env("HOME")}/.face`
                            }
                        }

                        Column {
                            spacing: 6
                            leftPadding: 16
                            Layout.fillWidth: true

                            StyledText {
                                text: Quickshell.env("USER") || "idiot"
                                font.weight: Font.DemiBold
                            }

                            StyledText {
                                text: "Uptime: " + Uptime.uptime
                                color: Qt.alpha(Colors.white, 0.8)
                                font.pointSize: Fonts.size.twoxs
                            }
                        }

                        Button {
                            id: powerMenuToggle
                            onClicked: powerPopup.toggle()

                            background: WrapperRectangle {
                                margin: 10
                                radius: 8
                                color: toggleHoverHandler.hovered ? Colors.black500 : Colors.black600

                                HoverHandler {
                                    id: toggleHoverHandler
                                    cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                                }

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 250
                                        easing.type: Easing.InOutQuad
                                    }
                                }

                                Icon {
                                    iconName: "power"
                                    size: 20
                                }
                            }
                        }
                    }
                }

                RowLayout {
                    Icon {
                        iconName: Updates.icon
                        size: 18
                        raw: true
                        Layout.rightMargin: 4
                    }

                    StyledText {
                        text: `Package Updates: ${Updates.arch} pacman | ${Updates.aur} AUR`
                        font.weight: Font.Medium
                    }

                    Process {
                        id: updateProc
                        command: ["bash", "-c", `kitty --class astal-paru-update --hold paru`]
                        running: false

                        stdout: StdioCollector {
                            onStreamFinished: {
                                Updates.forceUpdateRun();
                            }
                        }
                    }

                    Button {
                        id: downloadUpdatesButton
                        onClicked: updateProc.running = true
                        Layout.leftMargin: 12

                        background: WrapperRectangle {
                            margin: 6
                            radius: 8
                            color: downloadHoverHandler.hovered ? Colors.black600 : Colors.black700

                            HoverHandler {
                                id: downloadHoverHandler
                                cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                            }

                            Behavior on color {
                                ColorAnimation {
                                    duration: 250
                                    easing.type: Easing.InOutQuad
                                }
                            }

                            Icon {
                                iconName: "download"
                                size: 16
                            }
                        }
                    }
                }
            }
        }
    }
}
