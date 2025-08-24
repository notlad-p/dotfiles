// pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import qs.services
import qs.components
import qs.config
import qs.widgets

BarButton {
    id: root
    spacing: 12
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    RowLayout {
        spacing: 8
        Layout.alignment: Qt.AlignVCenter

        Icon {
            id: icon
            size: 16
            iconColor: Colors.white
            iconName: Weather.current.icon
        }

        StyledText {
            text: Weather.current.temperature
            pointSize: Fonts.size.xs
            font.weight: Font.Bold
        }
    }

    StyledText {
        text: Time.format("ddd, MMM d")
        pointSize: Fonts.size.xs
        font.weight: Font.Bold
    }

    StyledText {
        text: Time.format("h:mm ap")
        pointSize: Fonts.size.xs
        font.weight: Font.Bold
    }

    LazyLoader {
        id: selectorLoader
        // loading: true
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {
                spacing: 12

                // DateTime {
                //     Layout.fillWidth: true
                // }
                //
                // StyledText {
                //     Layout.alignment: Qt.AlignHCenter
                //     Layout.topMargin: -6
                //     Layout.bottomMargin: 4
                //     text: Time.format("dddd, MMMM d")
                //     color: Colors.white
                //     pointSize: 10.2
                //     font.weight: Font.DemiBold
                // }

                RowLayout {
                    spacing: 12
                    LocalCalendar {
                        // implicitWidth: weather.implicitWidth
                        implicitHeight: weather.implicitHeight
                    }

                    LocalWeather {
                        id: weather
                    }
                }
            }
        }
    }
}
