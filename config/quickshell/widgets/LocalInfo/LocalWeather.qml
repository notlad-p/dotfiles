import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import "root:/components"
import "root:/config"
import "root:/services"

WrapperRectangle {
    margin: 16
    color: Colors.black700
    radius: 8
    Layout.fillWidth: true

    ColumnLayout {
        spacing: 12

        WrapperItem {
            Layout.fillWidth: true

            RowLayout {
                spacing: 6

                Icon {
                    iconName: "location-pin"
                }

                StyledText {
                    text: Weather.city
                    font.weight: Font.Bold
                }

                RowLayout {
                    Layout.alignment: Qt.AlignRight

                    Icon {
                        visible: Weather.errorMessage !== ""
                        iconName: "warning"
                        iconColor: Colors.red
                        size: 18
                    }

                    StyledText {
                        visible: Weather.errorMessage !== ""
                        text: Weather.errorMessage
                        color: Colors.red
                        font.weight: Font.Bold
                    }
                }
            }
        }

        WrapperItem {
            Layout.fillWidth: true

            RowLayout {
                ColumnLayout {
                    spacing: 0
                    RowLayout {
                        spacing: 12
                        Icon {
                            iconName: Weather.current.icon
                            size: 32
                        }

                        StyledText {
                            text: Weather.current.temperature.slice(0, -1)
                            font.weight: Font.Bold
                            font.pointSize: Fonts.size.fourxl
                        }
                    }

                    StyledText {
                        Layout.topMargin: 4
                        text: Weather.current.description
                    }

                    RowLayout {
                        spacing: 0
                        Layout.topMargin: 8

                        Icon {
                            iconName: "arrow-down"
                            size: 16
                            opacity: 0.8
                            Layout.topMargin: 1
                        }
                        StyledText {
                            text: Weather.daily[0].lowTempText.slice(0, -1)
                            Layout.rightMargin: 12
                        }

                        Icon {
                            iconName: "arrow-up"
                            size: 16
                            opacity: 0.8
                        }
                        StyledText {
                            text: Weather.daily[0].highTempText.slice(0, -1)
                        }
                    }
                }

                ColumnLayout {
                    spacing: 12
                    Layout.alignment: Qt.AlignRight

                    RowLayout {
                        spacing: 6
                        Icon {
                            iconName: "precipitation-chance"
                            size: 16
                        }

                        StyledText {
                            text: `Precipitation: ${Weather.precipitationProb}%`
                        }
                    }

                    RowLayout {
                        spacing: 6
                        Icon {
                            iconName: "wind"
                        }

                        StyledText {
                            text: `Wind: ${Weather.current.windSpeed}`
                        }
                    }

                    RowLayout {
                        spacing: 6
                        Icon {
                            iconName: "humidity"
                        }

                        StyledText {
                            text: `Humidity: ${Weather.current.humidity}`
                        }
                    }
                }
            }
        }

        ColumnLayout {
            spacing: 8
            Layout.topMargin: 4

            WrapperRectangle {
                color: Colors.black600
                radius: 6
                margin: 12
                Layout.fillWidth: true

                RowLayout {
                    spacing: 24
                    Repeater {
                        model: 5

                        ColumnLayout {
                            required property int index
                            StyledText {
                                text: Weather.hourly[index].hour
                                Layout.alignment: Qt.AlignHCenter
                            }

                            Icon {
                                iconName: Weather.hourly[index].icon
                                Layout.topMargin: 4
                                Layout.alignment: Qt.AlignHCenter
                            }

                            StyledText {
                                text: Weather.hourly[index].temperature
                                Layout.topMargin: 6
                                Layout.alignment: Qt.AlignHCenter
                            }
                        }
                    }
                }
            }
            WrapperRectangle {
                color: Colors.black600
                radius: 6
                margin: 12
                Layout.fillWidth: true

                ColumnLayout {
                    spacing: 10
                    Repeater {
                        model: 3

                        RowLayout {
                            id: dailyRoot
                            required property int index
                            property int idx: index + 1
                            spacing: 0

                            StyledText {
                                // text: "Wednesday"
                                text: Weather.daily[idx].weekday
                                font.weight: Font.Medium
                                Layout.minimumWidth: 92
                            }

                            RowLayout {
                                spacing: 8

                                Icon {
                                    iconName: Weather.daily[idx].icon
                                    Layout.topMargin: 4
                                    Layout.alignment: Qt.AlignHCenter
                                    implicitWidth: 32
                                }

                                StyledText {
                                    text: Weather.daily[idx].lowTempText
                                    opacity: 0.6
                                    font.weight: Font.Medium
                                }

                                RangeSlider {
                                    id: rangeSlider
                                    enabled: false
                                    implicitWidth: 56
                                    from: Weather.minDailyTemp - 3
                                    to: Weather.maxDailyTemp + 3
                                    first.value: Weather.daily[idx].lowTemp
                                    first.handle: Item {}
                                    second.value: Weather.daily[idx].highTemp
                                    second.handle: Item {}

                                    background: Rectangle {
                                        x: rangeSlider.leftPadding
                                        y: rangeSlider.topPadding + rangeSlider.availableHeight / 2 - height / 2
                                        implicitWidth: 200
                                        implicitHeight: 4
                                        width: rangeSlider.availableWidth
                                        height: implicitHeight
                                        radius: 2
                                        color: Qt.alpha(Colors.white, 0.1)

                                        Rectangle {
                                            x: rangeSlider.first.visualPosition * parent.width
                                            width: rangeSlider.second.visualPosition * parent.width - x
                                            height: parent.height
                                            color: Colors.blue
                                            radius: 2
                                        }
                                    }
                                }

                                StyledText {
                                    text: Weather.daily[idx].highTempText
                                    opacity: 0.6
                                    font.weight: Font.Medium
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
