import QtQuick
import QtQuick.Layouts
import Quickshell.Widgets

import "root:/services"
import "root:/components"
import "root:/config"

RowLayout {
    Layout.fillWidth: true
    Layout.alignment: Qt.AlignHCenter
    // NOTE: width is set to prevent popup from resizing when time changes
    implicitWidth: 132
    spacing: 8

    StyledText {
        id: hourText
        text: Time.getHour()
        color: Colors.white
        font.weight: Font.Bold
        // font.pointSize: Fonts.size.threexl
        font.pointSize: Fonts.size.xl
    }

    Rectangle {
        implicitWidth: 3
        implicitHeight: hourText.implicitHeight * 0.75
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: Colors.blue
            }
            GradientStop {
                position: 1.0
                color: Colors.black600
            }
        }
    }

    StyledText {
        text: Time.format("mm")
        color: Colors.white
        font.weight: Font.Bold
        // font.pointSize: Fonts.size.threexl
        font.pointSize: Fonts.size.xl
    }

    WrapperItem {
        leftMargin: -4
        // bottomMargin: 6
        bottomMargin: 5
        // topMargin: -5

        Layout.alignment: Qt.AlignBottom
        StyledText {
            text: Time.format("ap")
            color: Colors.white
            font.weight: Font.Bold
            font.pointSize: Fonts.size.twoxs
        }
    }
}
