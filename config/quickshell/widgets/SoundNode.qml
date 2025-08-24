import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire

import qs.components
import qs.config
import qs.services
import "../scripts/get-volume-icon.js" as GetVolume

WrapperRectangle {
    id: root
    required property PwNode modelData
    required property int id
    required property string nickname
    required property PwNodeAudio audio
    required property bool isSink
    property bool isDefault: isSink ? id === Audio.sink.id : id === Audio.source.id
    property bool isOpen: false
    // property bool isOpen: true
    color: "transparent"
    Layout.fillWidth: true
    // onImplicitWidthChanged: {
    //     if (sinkList.implicitWidth < nodeText.implicitWidth) {
    //         sinkList.implicitWidth = nodeText.implicitWidth;
    //     }
    // }

    PwObjectTracker {
        objects: [modelData]
    }

    ColumnLayout {
        spacing: 4

        WrapperRectangle {
            radius: 8
            color: {
                if (root.isOpen) {
                    return Colors.black700;
                }

                if (hoverHandler.hovered) {
                    return Colors.black700;
                } else {
                    return Colors.black800;
                }
            }

            HoverHandler {
                id: hoverHandler
                cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
            }

            Behavior on color {
                ColorAnimation {
                    duration: 225
                    easing.type: Easing.InOutQuad
                }
            }

            RowLayout {
                RowLayout {
                    TapHandler {
                        onTapped: Pipewire.preferredDefaultAudioSink = root.modelData
                    }

                    WrapperRectangle {
                        margin: 8
                        radius: 8
                        color: "transparent"

                        Icon {
                            iconName: isSink ? "speaker-headphones" : "headset-mic"
                            size: 18
                            iconColor: root.isDefault ? Colors.blue : Colors.white

                            Behavior on iconColor {
                                ColorAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }

                    WrapperRectangle {
                        color: "transparent"
                        Layout.fillWidth: true
                        Layout.minimumWidth: 196

                        StyledText {
                            id: nodeText
                            text: root.nickname ? root.nickname : root.modelData.description
                            color: root.isDefault ? Colors.blue : Colors.white
                            font.weight: Font.Medium

                            Behavior on color {
                                ColorAnimation {
                                    duration: 200
                                    easing.type: Easing.InOutQuad
                                }
                            }
                        }
                    }
                }

                WrapperRectangle {
                    color: caretHoverHandler.hovered ? Colors.black600 : Qt.alpha(Colors.black600, 0)
                    radius: 8
                    margin: 8

                    TapHandler {
                        onTapped: root.isOpen = !root.isOpen
                    }

                    HoverHandler {
                        id: caretHoverHandler
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 225
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Icon {
                        iconName: "caret-small-down"
                        size: 16
                        Layout.preferredWidth: 16
                        Layout.preferredHeight: 16
                    }
                }
            }
        }

        WrapperRectangle {
            id: revealerRect
            Layout.fillWidth: true
            implicitHeight: root.isOpen ? wrapperRow.implicitHeight : 0
            // visible: root.isOpen || implicitHeight
            visible: false
            clip: true
            color: Colors.black700
            radius: 8
            property bool open: root.isOpen
            property real duration: 275
            transformOrigin: Item.Top

            onOpenChanged: {
                if (open) {
                    closeTimer.stop();
                    visible = true;
                } else {
                    closeTimer.start();
                }
            }

            Timer {
                id: closeTimer
                interval: revealerRect.duration + 50
                onTriggered: {
                    root.isOpen = false;
                }
            }

            Behavior on implicitHeight {
                NumberAnimation {
                    id: heightAnim
                    duration: revealerRect.duration
                    // easing.type: root.isOpen ? Easing.OutCubic : Easing.OutCubic
                    // easing.type: Easing.Linear
                    easing.type: Easing.OutCubic
                }
            }

            RowLayout {
                id: wrapperRow
                spacing: 8
                WrapperRectangle {
                    radius: 8
                    margin: 8
                    color: volumeIconHover.hovered ? Colors.black600 : Qt.alpha(Colors.black600, 0)
                    rightMargin: 8

                    Behavior on color {
                        ColorAnimation {
                            duration: 225
                            easing.type: Easing.InOutQuad
                        }
                    }

                    HoverHandler {
                        id: volumeIconHover
                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }

                    TapHandler {
                        onTapped: Audio.toggleMute(modelData)
                    }

                    Icon {
                        iconName: GetVolume.getVolumeIcon(modelData)
                        iconColor: root.audio.muted ? Colors.red : Colors.white
                        size: 16
                    }
                }

                Slider {
                    id: volumeSlider
                    Layout.fillWidth: true
                    value: root.modelData.audio.volume * 100
                    from: 0
                    to: 150
                    stepSize: 1
                    snapMode: Slider.SnapAlways

                    // Define the snap threshold (how close to 100 before snapping)
                    property real snapThreshold: 3
                    property real snapValue: 100

                    onValueChanged: {
                        if (root.audio) {
                            // console.log(Math.abs(value - snapValue))
                            if (Math.abs(value - snapValue) <= snapThreshold) {
                                // root.audio.volume = 1;
                                Audio.setVolume(modelData, 1);
                                return 1;
                            } else {
                                root.audio.volume = volumeSlider.value / 100;
                                Audio.setVolume(modelData, volumeSlider.value / 100);
                            }
                        }
                    }

                    onMoved: {
                        // Check if the current value is within the snap threshold of 100
                        if (Math.abs(value - snapValue) <= snapThreshold) {
                            value = snapValue;
                            // console.log(root.audio.volume)
                            // Audio.setVolume(modelData, snapValue / 100)
                            // root.audio.volume = snapValue / 100;
                        }
                    }

                    background: Item {
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        implicitWidth: parent.implicitWidth
                        implicitHeight: 3
                        width: volumeSlider.availableWidth
                        height: implicitHeight

                        Rectangle {
                            x: (volumeSlider.snapValue / (volumeSlider.to - volumeSlider.from)) * volumeSlider.background.width - width / 2
                            y: volumeSlider.background.height / 2 - height / 2
                            width: 3
                            height: volumeSlider.background.height + 10
                            radius: 2
                            color: Colors.black500
                        }

                        Rectangle {
                            anchors.fill: parent
                            radius: 2
                            color: Colors.black500

                            Rectangle {
                                width: volumeSlider.visualPosition * parent.width
                                height: parent.height
                                color: root.audio.muted ? Colors.black100 : Colors.white
                                radius: 2

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 200
                                        easing.type: Easing.InOutQuad
                                    }
                                }
                            }
                        }
                    }

                    handle: WrapperRectangle {
                        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        implicitWidth: 16
                        implicitHeight: 24
                        radius: 12
                        color: root.audio.muted ? Colors.black100 : Colors.white
                        border.width: 4
                        border.color: Colors.black700

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }
                    }
                }

                WrapperRectangle {
                    color: "transparent"
                    rightMargin: 8

                    WrapperItem {
                        implicitWidth: 36
                        StyledText {
                            text: `${Math.round(volumeSlider.value.toString())}%`
                            color: Qt.alpha(Colors.white, 0.6)
                            font.weight: Font.DemiBold
                        }
                    }
                }
            }
        }
    }
}
