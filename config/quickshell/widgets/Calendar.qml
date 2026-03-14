import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import qs.components

WrapperRectangle {
    id: root

    color: Theme.palette._surfaceContainerHigh
    radius: Theme.radius.large

    topMargin: 20
    bottomMargin: 20
    leftMargin: 12
    rightMargin: 12

    readonly property var today: new Date()
    readonly property int todayDay: today.getDate()
    readonly property int todayMonth: today.getMonth()
    readonly property int todayYear: today.getFullYear()

    property int displayMonth: today.getMonth()
    property int displayYear: today.getFullYear()

    readonly property var monthNames: [
        "Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug",
        "Sep", "Oct", "Nov", "Dec"
    ]

    /// True while any slide or snap-back animation is running.
    readonly property bool animating: slideAnimation.running || snapBackAnimation.running

    function prevMonth() { slideContainer.slide(-1) }
    function nextMonth() { slideContainer.slide(1) }

    function stepYear(delta) {
        if (root.animating) return
        displayYear += delta
        slideContainer.currentContent.contentYear = displayYear
    }

    /// Returns { month, year } for the month adjacent to the displayed one,
    /// handling year rollover.
    function adjacentMonth(direction) {
        let m = displayMonth + direction
        let y = displayYear
        if (m > 11) { m = 0; y++ }
        else if (m < 0) { m = 11; y-- }
        return { month: m, year: y }
    }

    Column {
        id: contentColumn

        // ── Header ──────────────────────────────────────────────────
        RowLayout {
            width: slideContainer.width
            spacing: 0

            CalendarNavControl {
                text: root.monthNames[root.displayMonth]
                labelWidth: 30
                onPrevClicked: root.prevMonth()
                onNextClicked: root.nextMonth()
            }

            Item { Layout.fillWidth: true }

            CalendarNavControl {
                id: yearControl
                text: root.displayYear
                labelWidth: yearMetrics.advanceWidth
                onPrevClicked: root.stepYear(-1)
                onNextClicked: root.stepYear(1)

                TextMetrics {
                    id: yearMetrics
                    font: yearControl.labelFont
                    text: "0000"
                }
            }
        }

        Item { width: 1; height: 30 }

        // ── Slide Container ──────────────────────────────────────────
        // Two CalendarContent panes overlap here. At rest, currentContent
        // sits at x=0 and incomingContent is off-screen. During a transition
        // both slide and cross-fade; on completion they swap roles so the
        // same two items are recycled indefinitely.

        Item {
            id: slideContainer

            implicitWidth: contentA.implicitWidth
            implicitHeight: contentA.implicitHeight
            width: implicitWidth
            height: implicitHeight
            clip: true

            property CalendarContent currentContent: contentA
            property CalendarContent incomingContent: contentB

            /// Side the incoming pane peeks from during a live drag.
            /// −1 = left (prev), +1 = right (next), 0 = none.
            property int peekDirection: 0

            /// Fraction of width the drag must cover to commit.
            readonly property real swipeThreshold: 0.30
            /// Fling velocity (px/s) that commits regardless of distance.
            readonly property real flingVelocity: 400

            // Chevron-click entry point. direction: +1 next, −1 prev.
            function slide(direction) {
                if (root.animating || swipeHandler.active) return

                const next = root.adjacentMonth(direction)

                // Pin outgoing pane so it doesn't react to the
                // displayMonth/Year changes below.
                currentContent.contentMonth = root.displayMonth
                currentContent.contentYear = root.displayYear

                // Update header labels immediately — feels more responsive.
                root.displayMonth = next.month
                root.displayYear = next.year

                incomingContent.contentMonth = next.month
                incomingContent.contentYear = next.year
                incomingContent.x = direction * width
                incomingContent.opacity = 0

                slideAnimation.direction = direction
                slideAnimation.start()
            }

            // Ensures the incoming pane shows the correct month during a
            // live drag. Only rebuilds when the drag direction flips.
            function preparePeek(direction) {
                if (peekDirection === direction) return
                peekDirection = direction

                const next = root.adjacentMonth(direction)
                incomingContent.contentMonth = next.month
                incomingContent.contentYear = next.year
            }

            function completeSwap() {
                const temp = currentContent
                currentContent = incomingContent
                incomingContent = temp

                currentContent.x = 0
                currentContent.opacity = 1
                incomingContent.opacity = 0
                peekDirection = 0
            }

            CalendarContent {
                id: contentA
                contentMonth: root.displayMonth
                contentYear: root.displayYear
            }

            CalendarContent {
                id: contentB
                contentMonth: root.displayMonth
                contentYear: root.displayYear
                opacity: 0
            }

            // ── Slide animation (committed transition) ───────────────
            // Opacity uses a shorter curve than x so the cross-fade
            // resolves while the slide is still easing into place.

            ParallelAnimation {
                id: slideAnimation
                property int direction: 1

                NumberAnimation {
                    target: slideContainer.currentContent; property: "x"
                    to: -slideAnimation.direction * slideContainer.width
                    duration: Theme.motion.expressiveSlowSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveSlowSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.currentContent; property: "opacity"; to: 0
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.incomingContent; property: "x"; to: 0
                    duration: Theme.motion.expressiveSlowSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveSlowSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.incomingContent; property: "opacity"; to: 1
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }

                onFinished: slideContainer.completeSwap()
            }

            // ── Snap-back (cancelled swipe) ──────────────────────────
            // A cancel should feel snappier than a commit.

            ParallelAnimation {
                id: snapBackAnimation

                NumberAnimation {
                    target: slideContainer.currentContent; property: "x"; to: 0
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.currentContent; property: "opacity"; to: 1
                    duration: Theme.motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.incomingContent; property: "x"
                    to: slideContainer.peekDirection * slideContainer.width
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.incomingContent; property: "opacity"; to: 0
                    duration: Theme.motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                }

                onFinished: slideContainer.peekDirection = 0
            }

            // ── Swipe gesture ────────────────────────────────────────
            // Both panes follow the finger in real time. On release,
            // commits if distance > swipeThreshold OR fling velocity
            // exceeds flingVelocity in the drag direction.

            DragHandler {
                id: swipeHandler
                target: null
                xAxis.enabled: true
                yAxis.enabled: false
                enabled: !root.animating

                onTranslationChanged: {
                    if (!active) return

                    const offset = translation.x
                    slideContainer.currentContent.x = offset

                    // 8 px dead-zone prevents peek flicker near center.
                    if (Math.abs(offset) > 8) {
                        // Dragging left (negative offset) → next month (+1).
                        const direction = offset < 0 ? 1 : -1
                        slideContainer.preparePeek(direction)

                        // Incoming pane trails one full width behind current.
                        slideContainer.incomingContent.x = offset + direction * slideContainer.width

                        const progress = Math.min(1, Math.abs(offset) / slideContainer.width)
                        slideContainer.incomingContent.opacity = progress
                        slideContainer.currentContent.opacity = 1 - progress
                    } else {
                        slideContainer.incomingContent.opacity = 0
                        slideContainer.currentContent.opacity = 1
                    }
                }

                onActiveChanged: {
                    if (active) return

                    const offset = slideContainer.currentContent.x
                    if (offset === 0 || slideContainer.peekDirection === 0) return

                    const velocity = centroid.velocity.x
                    const distanceMet = Math.abs(offset) > slideContainer.width * slideContainer.swipeThreshold
                    const flingMet = Math.abs(velocity) > slideContainer.flingVelocity
                                     && Math.sign(velocity) === Math.sign(offset)

                    if (distanceMet || flingMet) {
                        // Pin outgoing, update header, animate.
                        slideContainer.currentContent.contentMonth = root.displayMonth
                        slideContainer.currentContent.contentYear = root.displayYear
                        root.displayMonth = slideContainer.incomingContent.contentMonth
                        root.displayYear = slideContainer.incomingContent.contentYear

                        slideAnimation.direction = slideContainer.peekDirection
                        slideAnimation.start()
                    } else {
                        snapBackAnimation.start()
                    }
                }
            }
        }
    }

    // ─────────────────────────────────────────────────────────────────
    // CalendarNavControl — chevron pair with a fixed-width label.
    // ─────────────────────────────────────────────────────────────────

    component CalendarNavControl: Row {
        id: navControl

        property alias text: navLabel.text
        readonly property alias labelFont: navLabel.font
        property real labelWidth: navLabel.implicitWidth

        signal prevClicked()
        signal nextClicked()

        spacing: 20

        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            size: "xs"
            buttonWidth: "narrow"
            rounded: true
            iconName: "material/chevron_left"
            backgroundColor: "transparent"
            hoveredBackgroundColor: Qt.alpha(Theme.palette._onSurface, 0.08)
            onClicked: navControl.prevClicked()
        }

        Item {
            anchors.verticalCenter: parent.verticalCenter
            width: navControl.labelWidth
            height: navLabel.implicitHeight

            Text {
                id: navLabel
                anchors.centerIn: parent
                color: Theme.palette._onSurface
                font.pixelSize: 14
                font.weight: Font.Medium
            }
        }

        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            size: "xs"
            buttonWidth: "narrow"
            rounded: true
            iconName: "material/chevron_right"
            backgroundColor: "transparent"
            hoveredBackgroundColor: Qt.alpha(Theme.palette._onSurface, 0.08)
            onClicked: navControl.nextClicked()
        }
    }

    // ─────────────────────────────────────────────────────────────────
    // CalendarContent — one month's day-of-week header + grid.
    // ─────────────────────────────────────────────────────────────────

    component CalendarContent: Column {
        id: calContent

        property int contentMonth: root.todayMonth
        property int contentYear: root.todayYear

        DayOfWeekRow {
            locale: Qt.locale()

            delegate: Item {
                required property string narrowName
                width: 40; height: 24

                Text {
                    anchors.centerIn: parent
                    text: narrowName
                    color: Theme.palette._onSurface
                    font.pixelSize: 16
                    font.weight: Font.Medium
                }
            }
        }

        Item { width: 1; height: 16 }

        MonthGrid {
            month: calContent.contentMonth
            year: calContent.contentYear
            locale: Qt.locale()

            delegate: StyledButton {
                id: dayCell
                required property var model

                readonly property bool isCurrentMonth: model.month === calContent.contentMonth
                readonly property bool isTodayCell:
                    model.day === root.todayDay &&
                    model.month === root.todayMonth &&
                    model.year === root.todayYear

                width: 40
                height: 40
                horizontalPadding: 0

                // "md" for 16 px text; explicit width/height override its implicitHeight.
                size: "md"
                rounded: true

                text: model.day

                backgroundColor: "transparent"
                hoveredBackgroundColor: Qt.alpha(Theme.palette._onSurface, 0.08)

                textColor: {
                    if (isTodayCell) return Theme.palette._primary
                    if (!isCurrentMonth) return Theme.palette._outline
                    return Theme.palette._onSurface
                }

                // Width stays at 1 so only the color animates in/out.
                borderWidth: 1
                borderColor: isTodayCell ? Theme.palette._primary : "transparent"
            }
        }
    }
}
