import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

import "root:/components"
import "root:/config"
import "root:/services"

BarButton {
    id: root
    disableHover: true
    property int secondsEllapsed: 0

    // onClicked: () => {
    //     if (!selectorLoader.active) {
    //         selectorLoader.activeAsync = true;
    //     } else {
    //         selectorLoader.item.toggle();
    //     }
    // }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: StopWatchTimer.isRunning ? "pause" : "play"

        TapHandler {
            onTapped: StopWatchTimer.toggle()
        }
    }

    StyledText {
        Layout.minimumWidth: 60
        text: StopWatchTimer.timerText
        font.weight: Font.Bold
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "reset-timer"

        TapHandler {
            onTapped: StopWatchTimer.reset()
        }
    }

    // LazyLoader {
    //     id: selectorLoader
    //     loading: false
    //     onActiveAsyncChanged: selectorLoader.item.toggle()
    //
    //     BarPopup {
    //         id: popup
    //         parentContainer: root
    //
    //         ColumnLayout {
    //             spacing: 12
    //
    //             WrapperRectangle {
    //                 id: nodeRect
    //                 // required property string description
    //                 // required property int id
    //                 color: Colors.black600
    //
    //                 TapHandler {
    //                     // onTapped: nodeRect.implicitWidth = nodeRect.implicitWidth + 100
    //                     onTapped: nodeRect.implicitWidth += 100
    //                 }
    //                 StyledText {
    //                     text: "Hello there"
    //                     color: "white"
    //                 }
    //             }
    //
    //             WrapperRectangle {
    //                 id: heightRect
    //                 // required property string description
    //                 // required property int id
    //                 color: Colors.black600
    //
    //                 TapHandler {
    //                     // onTapped: nodeRect.implicitWidth = nodeRect.implicitWidth + 100
    //                     onTapped: heightRect.implicitHeight += 100
    //                 }
    //                 StyledText {
    //                     text: "Hello there"
    //                     color: "white"
    //                 }
    //             }
    //
    //             StyledText {
    //                 text: "Hello there"
    //                 color: "white"
    //             }
    //             StyledText {
    //                 text: "Hello there"
    //                 color: "white"
    //             }
    //             StyledText {
    //                 text: "Hello there"
    //                 color: "white"
    //             }
    //             StyledText {
    //                 text: "Hello there"
    //                 color: "white"
    //             }
    //         }
    //     }
    // }
}
