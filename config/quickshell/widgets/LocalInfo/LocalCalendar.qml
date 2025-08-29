import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets

import qs.services
import qs.components
import qs.config
import qs.widgets

WrapperRectangle {
    id: root
    margin: 16
    color: Colors.black800
    radius: 8

    function createLocaleDate(date): Date {
        let dayDate;
        if (date) {
            dayDate = new Date(date);
        } else {
            dayDate = new Date();
        }

        dayDate.setMinutes(dayDate.getMinutes() + dayDate.getTimezoneOffset());
        return dayDate;
    }

    ColumnLayout {

        WrapperItem {
            Layout.fillWidth: true
            bottomMargin: 12

            RowLayout {
                StyledText {
                    text: Time.format("dddd, MMMM d")
                    color: Colors.white
                    pointSize: 10.2
                    font.weight: Font.Bold
                }

                StyledText {
                    Layout.alignment: Qt.AlignRight
                    Layout.minimumWidth: 64
                    text: Time.format("h:mm ap")
                    color: Colors.white
                    pointSize: 10.2
                    font.weight: Font.Bold
                    opacity: 0.6
                }
            }
        }

        WrapperRectangle {
            margin: 4
            radius: 8
            color: Colors.black700
            Layout.fillWidth: true
            Layout.bottomMargin: 4

            RowLayout {
                CalendarNavButton {
                    btnType: "decrement"
                    listView: listView
                }

                StyledText {
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true

                    font.weight: Font.DemiBold
                    text: {
                        const month = listView.currentItem.month + 1;
                        const year = listView.currentItem.year;
                        const dateStr = `${year}-${String(month).padStart(2, "0")}-07`;

                        // TODO: add locale/translation
                        return Qt.formatDateTime(root.createLocaleDate(dateStr), "MMMM, yyyy");
                    }

                    TapHandler {
                        onTapped: {
                            listView.positionViewAtIndex(listView.maxMonths, ListView.SnapPosition);
                        }
                    }
                }

                CalendarNavButton {
                    btnType: "increment"
                    listView: listView
                }
            }
        }

        WrapperItem {
            Layout.alignment: Qt.AlignHCenter

            DayOfWeekRow {
                spacing: listView.monthGridSpacing
                locale: Qt.locale("en_US")

                delegate: StyledText {
                    width: listView.daySize
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: model.shortName.slice(0, 2)
                    color: Qt.alpha(Colors.white, 0.6)
                    font.weight: Font.Bold
                }
            }
        }

        ListView {
            id: listView
            property int daySize: 28
            property int monthGridSpacing: 10
            // maximum number of months to show forward/back (total months will be double maxMonths)
            property int maxMonths: 24

            Layout.alignment: Qt.AlignHCenter

            spacing: 24
            implicitWidth: 7 * daySize + monthGridSpacing * 6
            implicitHeight: 6 * daySize + monthGridSpacing * 5
            snapMode: ListView.SnapOneItem
            orientation: ListView.Horizontal
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 300
            currentIndex: maxMonths
            clip: true

            model: CalendarModel {
                id: calModel
                from: {
                    const prev = new Date();
                    prev.setMonth(prev.getMonth() - listView.maxMonths);
                    prev.setDate(1);
                    prev.setMinutes(prev.getMinutes() + prev.getTimezoneOffset());

                    return prev;
                }
                to: {
                    const next = new Date();
                    next.setMonth(next.getMonth() + listView.maxMonths + 1);
                    next.setDate(0);
                    next.setMinutes(next.getMinutes() + next.getTimezoneOffset());

                    return next;
                }
            }

            delegate: MonthGrid {
                id: monthGrid
                spacing: listView.monthGridSpacing
                month: model.month
                year: model.year
                locale: Qt.locale("en_US")

                delegate: WrapperRectangle {
                    id: dayWrapper
                    required property var model
                    implicitWidth: listView.daySize
                    implicitHeight: listView.daySize
                    color: {
                        const today = new Date();
                        const dayDate = root.createLocaleDate(dayWrapper.model.date);

                        if (dayDate.toLocaleDateString() === today.toLocaleDateString()) {
                            // console.log(today.toLocaleString());
                            return dayHoverHandler.hovered ? Qt.lighter(Colors.blue, 1.2) : Colors.blue;
                        }
                        return dayHoverHandler.hovered ? Qt.alpha(Colors.white, 0.05) : Qt.alpha(Colors.white, 0);
                    }
                    radius: 5

                    HoverHandler {
                        id: dayHoverHandler
                        cursorShape: hovered ? Qt.PointingHandCursor : Qt.ArrowCursor
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }

                    Text {

                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: model.month === monthGrid.month ? 1 : 0.3
                        color: {
                            const today = new Date();
                            const dayDate = root.createLocaleDate(dayWrapper.model.date);

                            if (dayDate.toLocaleDateString() === today.toLocaleDateString()) {
                                return Colors.black800;
                            }
                            return Colors.white;
                        }
                        text: {
                            // NOTE: this is done to account for timezone, without it each day will be off by one
                            const dayDate = root.createLocaleDate(dayWrapper.model.date);
                            return monthGrid.locale.toString(dayDate, "d");
                        }
                        font.pointSize: 10
                        font.weight: Font.DemiBold
                    }
                }
            }

            // ScrollIndicator.horizontal: ScrollIndicator {}
        }
    }
}
