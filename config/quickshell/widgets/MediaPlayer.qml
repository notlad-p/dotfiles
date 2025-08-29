import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import Quickshell.Widgets
import Quickshell.Services.Mpris

import qs.services
import qs.components
import qs.config

ClippingRectangle {
    id: root
    required property MprisPlayer player

    color: Colors.black800
    radius: 8
    implicitWidth: 300
    implicitHeight: 150

    function lengthStr(length: int): string {
        if (length < 0)
            return "-1:-1";

        const hours = Math.floor(length / 3600);
        const mins = Math.floor((length % 3600) / 60);
        const secs = Math.floor(length % 60).toString().padStart(2, "0");

        if (hours > 0)
            return `${hours}:${mins.toString().padStart(2, "0")}:${secs}`;
        return `${mins}:${secs}`;
    }

    Image {
        id: backgroundImage
        source: root.player.trackArtUrl ?? ""
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        clip: true
    }

    Rectangle {
        anchors.fill: backgroundImage
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 0.01
                color: Colors.black700
            }
            GradientStop {
                position: 0.5
                color: Qt.alpha(Colors.black700, 0.2)
            }
            GradientStop {
                position: 0.99
                color: Colors.black700
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: 12

        ColumnLayout {
            spacing: 22
            anchors.fill: parent

            FrameAnimation {
                running: root.player.playbackState == MprisPlaybackState.Playing
                onTriggered: root.player.positionChanged()
            }

            WrapperItem {
                Layout.fillWidth: true
                RowLayout {
                    Icon {
                        size: 20
                        iconColor: Players.getIconColor(root.player.identity)
                        iconName: Players.getIconName(root.player.identity)
                    }

                    StyledText {
                        text: root.lengthStr(Math.floor(root.player.position)) + " / " + root.lengthStr(root.player.length)
                        color: Colors.white
                        pointSize: Fonts.size.twoxs

                        Layout.alignment: Qt.AlignRight
                    }
                }
            }

            WrapperItem {
                Layout.fillWidth: true

                RowLayout {
                    spacing: 16
                    ColumnLayout {
                        WrapperItem {
                            id: trackTitleItem
                            property int spacing: 30
                            implicitWidth: 220
                            clip: true
                            Layout.maximumHeight: 20

                            StyledText {
                                id: trackTitleText
                                text: root.player.trackTitle || ""
                                color: Colors.white
                                font.weight: Font.Bold
                                pointSize: Fonts.size.sm

                                onImplicitWidthChanged: () => {
                                    textScrollAnimation.stop();
                                    trackTitleText.x = 0;
                                    if (trackTitleText.implicitWidth > trackTitleItem.implicitWidth) {
                                        textScrollAnimation.start();
                                    }
                                }

                                StyledText {
                                    id: wrapTitleText
                                    visible: trackTitleText.implicitWidth > trackTitleItem.implicitWidth
                                    text: root.player.trackTitle
                                    color: Colors.white
                                    font.weight: Font.Bold
                                    pointSize: Fonts.size.sm
                                    x: trackTitleText.implicitWidth + trackTitleItem.spacing
                                }

                                SequentialAnimation on x {
                                    id: textScrollAnimation
                                    running: true
                                    loops: Animation.Infinite
                                    PauseAnimation {
                                        duration: 1000
                                    }
                                    NumberAnimation {
                                        from: 0
                                        to: -trackTitleText.implicitWidth - trackTitleItem.spacing
                                        duration: {
                                            // calculate duration as pixels per second (180 pixels per second)
                                            const distance = wrapTitleText.implicitWidth * 2 + trackTitleItem.spacing;
                                            const dur = distance / 180 * 1000;
                                            return dur;
                                        }
                                    }
                                }
                            }
                        }

                        StyledText {
                            text: root.player.trackArtist || "Unknown Artist"
                            color: Colors.white
                        }
                    }

                    WrapperRectangle {
                        margin: 9
                        radius: 8
                        color: playHoverHandler.hovered ? Qt.alpha(Colors.white, 0.38) : Qt.alpha(Colors.white, 0.3)
                        Layout.alignment: Qt.AlignRight

                        TapHandler {
                            onTapped: {
                                root.player.togglePlaying();
                            }
                        }

                        HoverHandler {
                            id: playHoverHandler
                            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        Behavior on color {
                            ColorAnimation {
                                duration: 200
                                easing.type: Easing.InOutQuad
                            }
                        }

                        Icon {
                            size: 16
                            iconColor: Colors.white
                            iconName: root.player.isPlaying ? "pause" : "play"
                        }
                    }
                }
            }

            RowLayout {

                WrapperRectangle {
                    margin: 2
                    color: "transparent"

                    TapHandler {
                        onTapped: {
                            if (root.player.canGoPrevious) {
                                root.player.previous();
                            }
                        }
                    }

                    HoverHandler {
                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }

                    Icon {
                        size: 16
                        iconColor: Colors.white
                        iconName: "previous-track"
                    }
                }

                Slider {
                    id: volumeSlider
                    Layout.fillWidth: true
                    value: root.player.position / root.player.length * 100
                    from: 0
                    to: 100

                    onMoved: {
                        const offset = value / 100 * root.player.length - root.player.position;
                        if (root.player.canSeek && root.player.positionSupported) {
                            root.player.seek(offset);
                        }
                    }
                    stepSize: 1

                    background: Item {
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        implicitWidth: parent.implicitWidth
                        implicitHeight: 4
                        width: volumeSlider.availableWidth
                        height: implicitHeight

                        HoverHandler {
                            cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                        }

                        Rectangle {
                            anchors.fill: parent
                            radius: 2
                            color: Qt.alpha(Colors.white, 0.3)

                            Rectangle {
                                width: volumeSlider.visualPosition * parent.width
                                height: parent.height
                                color: Colors.white
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

                    handle: Item {}
                }

                WrapperRectangle {
                    margin: 2
                    color: "transparent"

                    TapHandler {
                        onTapped: {
                            if (root.player.canGoNext) {
                                root.player.next();
                            }
                        }
                    }

                    HoverHandler {
                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }

                    Icon {
                        size: 16
                        iconColor: Colors.white
                        iconName: "next-track"
                    }
                }
            }
        }
    }
}
