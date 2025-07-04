import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire

import "root:/components"
import "root:/config"
import "root:/services"

BarButton {
    id: root
    spacing: 10
    onClicked: () => {
        // if (!selectorLoader.active) {
        //     selectorLoader.activeAsync = true;
        // } else {
        //     selectorLoader.item.toggle();
        // }
        popup.toggle();
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "volume-high"
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "microphone-high"
    }

    // LazyLoader {
    //     id: selectorLoader
    //     loading: false
    //     onActiveAsyncChanged: selectorLoader.item.toggle()
    //
    // }
    BarPopup {
        id: popup
        parentContainer: root

        ColumnLayout {
            anchors.top: parent.top
            spacing: 12

            RowLayout {
                spacing: 6

                Button {
                    id: sinkMuteButton
                    onClicked: Audio.toggleMute(Audio.sink)

                    background: WrapperRectangle {
                        margin: 8
                        radius: 8
                        color: {
                            if (Audio.sinkMuted) {
                                return sinkHoverHandler.hovered ? Colors.black600 : Colors.black700;
                            } else {
                                return sinkHoverHandler.hovered ? Qt.lighter(Colors.blue, 1.1) : Colors.blue;
                            }
                        }

                        HoverHandler {
                            id: sinkHoverHandler
                            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Icon {
                            iconName: Audio.sinkMuted ? "volume-mute" : "volume-high"
                            iconColor: Audio.sinkMuted ? Colors.red : Colors.black900
                        }
                    }
                }

                Button {
                    id: sourceMuteButton
                    onClicked: Audio.toggleMute(Audio.source)

                    background: WrapperRectangle {
                        margin: 8
                        radius: 8
                        color: {
                            if (Audio.sourceMuted) {
                                return sourceHoverHandler.hovered ? Colors.black600 : Colors.black700;
                            } else {
                                return sourceHoverHandler.hovered ? Qt.lighter(Colors.blue, 1.1) : Colors.blue;
                            }
                        }

                        HoverHandler {
                            id: sourceHoverHandler
                            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Icon {
                            iconName: Audio.sourceMuted ? "microphone-mute" : "microphone-high"
                            iconColor: Audio.sourceMuted ? Colors.red : Colors.black900
                        }
                    }
                }
            }

            WrapperRectangle {
                margin: 12
                radius: 8
                color: Colors.black800

                ColumnLayout {
                    spacing: 4

                    WrapperRectangle {
                        color: "transparent"
                        bottomMargin: 4
                        StyledText {
                            text: "Output Devices"
                            font.weight: Font.Bold
                            font.pointSize: 10
                        }
                    }

                    Repeater {
                        id: sinkList
                        model: Pipewire.ready ? Audio.nodes.values.filter(e => e.type === PwNodeType.AudioSink).sort((a, b) => a.nickname.localeCompare(b.nickname)) : null
                        delegate: SoundNode {}
                    }
                }

                // ListView {
                //     id: sinkList
                //     implicitHeight: contentHeight
                //     spacing: 6
                //     model: Pipewire.ready ? Audio.nodes.values.filter(e => e.type === PwNodeType.AudioSink) : null
                //     delegate: audioNode
                // }
            }

            WrapperRectangle {
                margin: 12
                radius: 8
                color: Colors.black800

                ColumnLayout {
                    spacing: 4

                    WrapperRectangle {
                        color: "transparent"
                        bottomMargin: 4
                        StyledText {
                            text: "Input Devices"
                            font.weight: Font.Bold
                            font.pointSize: 10
                        }
                    }

                    Repeater {
                        id: sourceList
                        model: Pipewire.ready ? Audio.nodes.values.filter(e => e.type === PwNodeType.AudioSource).sort((a, b) => a.nickname.localeCompare(b.nickname)) : null
                        delegate: SoundNode {}
                    }
                }
            }
        }
    }
}
