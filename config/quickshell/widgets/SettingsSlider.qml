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

RowLayout {
    id: root
    property string iconName
    property string iconColor
    property real value
    // iconClick function
    signal iconClicked(int button)
    spacing: 8
    WrapperRectangle {
        radius: 8
        margin: 8
        color: volumeIconHover.hovered ? Colors.black600 : Qt.alpha(Colors.black600, 0)

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
            // onTapped: Audio.toggleMute(modelData)
            onTapped: (point, button) => {
                root.iconClicked(button);
            }
        }

        Icon {
            anchors.centerIn: parent
            // iconName: GetVolume.getVolumeIcon(modelData)
            // iconColor: root.audio.muted ? Colors.red : Colors.white
            iconName: root.iconName
            iconColor: Qt.darker(Colors.white, 1.05)
            size: 16
        }
    }

    Slider {
        id: volumeSlider
        Layout.fillWidth: true
        // value: root.modelData.audio.volume * 100
        value: 100
        from: 0
        to: 100
        stepSize: 1
        snapMode: Slider.SnapAlways

        // Define the snap threshold (how close to 100 before snapping)
        // property real snapThreshold: 3
        property real snapValue: 100

        onValueChanged: {
            if (root.audio)
            // Audio.setVolume(modelData, volumeSlider.value / 100);
            {}
        }

        // onMoved: {
        //     // Check if the current value is within the snap threshold of 100
        //     if (Math.abs(value - snapValue) <= snapThreshold) {
        //         value = snapValue;
        //     }
        // }

        background: Item {
            x: volumeSlider.leftPadding
            y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
            implicitWidth: parent.implicitWidth
            implicitHeight: 4
            width: volumeSlider.availableWidth
            height: implicitHeight

            // Rectangle {
            //     x: (volumeSlider.snapValue / (volumeSlider.to - volumeSlider.from)) * volumeSlider.background.width - width / 2
            //     y: volumeSlider.background.height / 2 - height / 2
            //     width: 3
            //     height: volumeSlider.background.height + 10
            //     radius: 2
            //     color: Colors.black500
            // }

            Rectangle {
                anchors.fill: parent
                radius: 2
                color: Colors.black500

                Rectangle {
                    width: volumeSlider.visualPosition * parent.width
                    height: parent.height
                    // color: root.audio.muted ? Colors.black100 : Colors.white
                    color: Qt.darker(Colors.white, 1.2)
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
            // color: root.audio.muted ? Colors.black100 : Colors.white
            // color: Qt.darker(Colors.blue, 1.1)
            color: Qt.darker(Colors.white, 1.2)
            border.width: 4
            border.color: Colors.black800

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
        // rightMargin: 8

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
