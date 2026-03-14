import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import qs.config
import qs.components

// ─────────────────────────────────────────────────────────────────────────────
// Calendar.qml — Material 3 month calendar with animated month transitions
//
// Layout (top → bottom):
//   1. Header row — month chevrons + label (left), year chevrons + label (right)
//   2. Slide container — holds two CalendarContent panes (day-of-week row +
//      MonthGrid) that cross-fade and slide when the month changes.
//
// Month transitions are triggered in two ways:
//   • Chevron click — calls slide(±1), which stages the incoming pane
//     off-screen and kicks off slideAnimation.
//   • Swipe gesture — a DragHandler tracks horizontal drag. While the finger
//     moves, both panes follow in real-time. On release the gesture either
//     commits (slideAnimation) or cancels (snapBackAnimation) based on
//     distance and fling velocity thresholds.
//
// Two CalendarContent instances (contentA / contentB) alternate roles:
//   • currentContent  — the visible, on-screen pane
//   • incomingContent — staged off-screen, ready to slide in
//   After every completed transition the two swap roles (completeSwap()),
//   so the same two items are recycled indefinitely.
// ─────────────────────────────────────────────────────────────────────────────

WrapperRectangle {
    id: root

    color: Theme.palette._surfaceContainerHigh
    radius: Theme.radius.large

    topMargin: 20
    bottomMargin: 20
    leftMargin: 12
    rightMargin: 12

    // ── Date state ───────────────────────────────────────────────────
    // "today*" values are snapshot at component creation and used to
    // highlight the current day.  "display*" track the month/year the
    // user is viewing and are updated when navigating.

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
    /// Used to guard against overlapping transitions.
    readonly property bool animating: slideAnimation.running || snapBackAnimation.running

    // ── Navigation helpers ───────────────────────────────────────────

    function prevMonth() { slideContainer.slide(-1) }
    function nextMonth() { slideContainer.slide(1) }

    function prevYear() {
        if (root.animating) return
        displayYear -= 1
        slideContainer.currentContent.contentYear = displayYear
    }

    function nextYear() {
        if (root.animating) return
        displayYear += 1
        slideContainer.currentContent.contentYear = displayYear
    }

    // ─────────────────────────────────────────────────────────────────
    // Main layout column
    // ─────────────────────────────────────────────────────────────────

    Column {
        id: contentColumn

        // ── Header Row ──────────────────────────────────────────────
        Row {
            id: headerRow
            width: slideContainer.width
            spacing: 0

            // Month controls — left side
            Row {
                id: monthControls
                spacing: 0
                anchors.verticalCenter: parent.verticalCenter

                NavButton {
                    iconName: "material/chevron_left"
                    onClicked: root.prevMonth()
                }

                Item { width: 20; height: 1 }

                // Fixed-width container keeps the label centered regardless
                // of which 3-letter month abbreviation is shown.
                Item {
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                    height: monthLabel.implicitHeight

                    Text {
                        id: monthLabel
                        anchors.centerIn: parent
                        text: root.monthNames[root.displayMonth]
                        color: Theme.palette._onSurface
                        font.pixelSize: 14
                        font.weight: Font.Medium
                    }
                }

                Item { width: 20; height: 1 }

                NavButton {
                    iconName: "material/chevron_right"
                    onClicked: root.nextMonth()
                }
            }

            // Spacer pushes year controls to the right
            Item {
                width: slideContainer.width - monthControls.implicitWidth - yearControls.implicitWidth
                height: 1
            }

            // Year controls — right side
            Row {
                id: yearControls
                spacing: 0
                anchors.verticalCenter: parent.verticalCenter

                NavButton {
                    iconName: "material/chevron_left"
                    onClicked: root.prevYear()
                }

                Item { width: 20; height: 1 }

                Item {
                    id: yearLabelContainer
                    anchors.verticalCenter: parent.verticalCenter
                    height: yearLabel.implicitHeight
                    width: yearMetrics.advanceWidth

                    TextMetrics {
                        id: yearMetrics
                        font: yearLabel.font
                        text: "0000"
                    }

                    Text {
                        id: yearLabel
                        anchors.centerIn: parent
                        text: root.displayYear
                        color: Theme.palette._onSurface
                        font.pixelSize: 14
                        font.weight: Font.Medium
                    }
                }

                Item { width: 20; height: 1 }

                NavButton {
                    iconName: "material/chevron_right"
                    onClicked: root.nextYear()
                }
            }
        }

        // Spacing between header and slide container
        Item { width: 1; height: 30 }

        // ── Slide Container ──────────────────────────────────────────
        // Clips two overlapping CalendarContent panes whose x and opacity
        // are animated during month transitions.
        //
        // Pane lifecycle:
        //   idle       → currentContent at x=0, opacity=1
        //                 incomingContent off-screen, opacity=0
        //   animating  → both panes moving + fading
        //   finished   → completeSwap() makes incoming the new current
        // ─────────────────────────────────────────────────────────────

        Item {
            id: slideContainer

            implicitWidth: contentA.implicitWidth
            implicitHeight: contentA.implicitHeight
            width: implicitWidth
            height: implicitHeight
            clip: true

            /// Pane currently visible at rest.
            property CalendarContent currentContent: contentA
            /// Pane staged off-screen, ready to slide in.
            property CalendarContent incomingContent: contentB

            /// Direction the incoming pane peeks from during a live drag.
            /// −1 = peeking from the left (dragging right → previous month)
            /// +1 = peeking from the right (dragging left → next month)
            ///  0 = no peek active
            property int peekDirection: 0

            // ── Swipe tuning ─────────────────────────────────────────
            /// Fraction of container width the drag must cover to commit.
            readonly property real swipeThreshold: 0.30
            /// Minimum fling velocity (px/s) that commits regardless of distance.
            readonly property real flingVelocity: 400

            // ── slide() ──────────────────────────────────────────────
            // Called by chevron clicks.  Stages the incoming pane off-screen
            // on the appropriate side, updates the header labels immediately,
            // then starts the slide + fade animation.
            //
            // direction: +1 → next month (content exits left, enters right)
            //            −1 → prev month (content exits right, enters left)

            function slide(direction) {
                if (root.animating || swipeHandler.active) return

                let m = root.displayMonth + direction
                let y = root.displayYear
                if (m > 11) { m = 0; y++ }
                else if (m < 0) { m = 11; y-- }

                // Pin outgoing pane to current month so it doesn't react to
                // displayMonth/Year changes below.
                currentContent.contentMonth = root.displayMonth
                currentContent.contentYear = root.displayYear

                // Update header labels right away (feels more responsive).
                root.displayMonth = m
                root.displayYear = y

                // Position incoming pane off-screen on the entry side.
                incomingContent.contentMonth = m
                incomingContent.contentYear = y
                incomingContent.x = direction * width
                incomingContent.opacity = 0

                slideAnimation.direction = direction
                slideAnimation.start()
            }

            // ── preparePeek() ────────────────────────────────────────
            // During a live drag, ensures the incoming pane shows the
            // correct month for the direction the user is dragging.
            // Called repeatedly but only rebuilds when direction changes.

            function preparePeek(direction) {
                if (peekDirection === direction) return
                peekDirection = direction

                let m = root.displayMonth + direction
                let y = root.displayYear
                if (m > 11) { m = 0; y++ }
                else if (m < 0) { m = 11; y-- }

                incomingContent.contentMonth = m
                incomingContent.contentYear = y
            }

            // ── completeSwap() ───────────────────────────────────────
            // Runs after every committed transition.  Swaps the two panes'
            // roles so the old outgoing pane becomes the next incoming.

            function completeSwap() {
                const temp = currentContent
                currentContent = incomingContent
                incomingContent = temp

                // Reset positions so idle state is clean.
                currentContent.x = 0
                currentContent.opacity = 1
                incomingContent.opacity = 0

                peekDirection = 0
            }

            // ── The two recycled panes ───────────────────────────────

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
            // Runs when a month change is confirmed (chevron click or
            // swipe past threshold).
            //
            // Spatial properties (x) use expressiveSlowSpatial for a
            // smooth, slightly overshooting settle.  Opacity uses
            // expressiveDefaultSpatial (shorter) so the cross-fade
            // resolves before the slide finishes — the new content is
            // fully opaque while it's still easing into position.

            ParallelAnimation {
                id: slideAnimation

                /// +1 = next month, −1 = previous month
                property int direction: 1

                // ── Outgoing pane ────────────────────────────────────

                // Slide out (spatial — slow expressive)
                NumberAnimation {
                    target: slideContainer.currentContent
                    property: "x"
                    to: -slideAnimation.direction * slideContainer.width
                    duration: Theme.motion.expressiveSlowSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveSlowSpatial.bezierCurve
                }
                // Fade out (spatial — default, resolves mid-slide)
                NumberAnimation {
                    target: slideContainer.currentContent
                    property: "opacity"
                    to: 0
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }

                // ── Incoming pane ────────────────────────────────────

                // Slide in (spatial — slow expressive)
                NumberAnimation {
                    target: slideContainer.incomingContent
                    property: "x"
                    to: 0
                    duration: Theme.motion.expressiveSlowSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveSlowSpatial.bezierCurve
                }
                // Fade in (spatial — default, resolves mid-slide)
                NumberAnimation {
                    target: slideContainer.incomingContent
                    property: "opacity"
                    to: 1
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }

                onFinished: slideContainer.completeSwap()
            }

            // ── Snap-back animation (cancelled swipe) ────────────────
            // Runs when the user releases a drag that didn't meet the
            // commit threshold.  Returns both panes to their rest state.
            // Uses default spatial — a cancel should feel snappier than
            // a committed transition.

            ParallelAnimation {
                id: snapBackAnimation

                // Current pane returns to origin
                NumberAnimation {
                    target: slideContainer.currentContent
                    property: "x"
                    to: 0
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.currentContent
                    property: "opacity"
                    to: 1
                    duration: Theme.motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                }

                // Incoming pane retreats off-screen
                NumberAnimation {
                    target: slideContainer.incomingContent
                    property: "x"
                    to: slideContainer.peekDirection * slideContainer.width
                    duration: Theme.motion.expressiveDefaultSpatial.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultSpatial.bezierCurve
                }
                NumberAnimation {
                    target: slideContainer.incomingContent
                    property: "opacity"
                    to: 0
                    duration: Theme.motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                }

                onFinished: slideContainer.peekDirection = 0
            }

            // ── Swipe gesture (DragHandler) ──────────────────────────
            // Tracks horizontal drags on the slide container.  While the
            // finger is down both panes follow in real-time — the current
            // pane moves with the finger and the incoming pane peeks in
            // from the opposite edge.
            //
            // On release, two criteria are checked:
            //   1. Distance — did the drag exceed swipeThreshold?
            //   2. Fling    — is the release velocity above flingVelocity
            //                  in the same direction as the drag?
            // If either is met the transition commits (slideAnimation),
            // otherwise it cancels (snapBackAnimation).
            //
            // A small dead-zone (8 px) around center prevents the peek
            // pane from flickering when the user wobbles across zero.

            DragHandler {
                id: swipeHandler
                target: null
                xAxis.enabled: true
                yAxis.enabled: false
                enabled: !root.animating

                onTranslationChanged: {
                    if (!active) return

                    const offset = translation.x

                    // Move current pane with the finger.
                    slideContainer.currentContent.x = offset

                    if (Math.abs(offset) > 8) {
                        // Determine peek direction from drag offset.
                        // Dragging left (negative) → next month (+1).
                        // Dragging right (positive) → previous month (−1).
                        const direction = offset < 0 ? 1 : -1
                        slideContainer.preparePeek(direction)

                        // Incoming pane sits one full width behind the
                        // current pane, creating a continuous strip.
                        slideContainer.incomingContent.x = offset + direction * slideContainer.width

                        // Opacity tracks drag progress linearly.
                        const progress = Math.min(1, Math.abs(offset) / slideContainer.width)
                        slideContainer.incomingContent.opacity = progress
                        slideContainer.currentContent.opacity = 1 - progress
                    } else {
                        // Inside dead-zone — hide peek, restore current.
                        slideContainer.incomingContent.opacity = 0
                        slideContainer.currentContent.opacity = 1
                    }
                }

                onActiveChanged: {
                    if (active) return
                    // Finger released — decide commit vs cancel.

                    const offset = slideContainer.currentContent.x
                    if (offset === 0 || slideContainer.peekDirection === 0) return

                    const velocity = centroid.velocity.x
                    const distanceMet = Math.abs(offset) > slideContainer.width * slideContainer.swipeThreshold
                    // Fling must be in the same direction as the drag.
                    const flingMet = Math.abs(velocity) > slideContainer.flingVelocity
                                     && Math.sign(velocity) === Math.sign(offset)

                    if (distanceMet || flingMet) {
                        // Commit — pin outgoing pane, update header, animate.
                        slideContainer.currentContent.contentMonth = root.displayMonth
                        slideContainer.currentContent.contentYear = root.displayYear

                        root.displayMonth = slideContainer.incomingContent.contentMonth
                        root.displayYear = slideContainer.incomingContent.contentYear

                        slideAnimation.direction = slideContainer.peekDirection
                        slideAnimation.start()
                    } else {
                        // Cancel — return both panes to rest.
                        snapBackAnimation.start()
                    }
                }
            }
        }
    }

    // ─────────────────────────────────────────────────────────────────
    // CalendarContent — day-of-week header + month grid
    //
    // A self-contained column showing one month.  Two instances live
    // inside the slide container and swap between current/incoming roles.
    // contentMonth and contentYear are set explicitly during transitions
    // to decouple each pane from the shared displayMonth/displayYear.
    // ─────────────────────────────────────────────────────────────────

    component CalendarContent: Column {
        id: calContent

        property int contentMonth: root.todayMonth
        property int contentYear: root.todayYear

        // ── Day-of-week row (Mon … Sun) ─────────────────────────────
        DayOfWeekRow {
            locale: Qt.locale()

            delegate: Item {
                required property string narrowName

                width: 40
                height: 24

                Text {
                    anchors.centerIn: parent
                    text: narrowName
                    color: Theme.palette._onSurface
                    font.pixelSize: 16
                    font.weight: Font.Medium
                }
            }
        }

        // Spacing between day-of-week and grid
        Item { width: 1; height: 16 }

        // ── Month grid ──────────────────────────────────────────────
        MonthGrid {
            month: calContent.contentMonth
            year: calContent.contentYear
            locale: Qt.locale()

            delegate: Item {
                id: dayCell

                required property var model

                /// True when this cell's date falls within the displayed month.
                readonly property bool isCurrentMonth:
                    model.month === calContent.contentMonth

                /// True when this cell represents today's date.
                readonly property bool isTodayCell:
                    model.day === root.todayDay &&
                    model.month === root.todayMonth &&
                    model.year === root.todayYear

                width: 40
                height: 40

                // Today — circular outline
                Rectangle {
                    anchors.centerIn: parent
                    width: 40
                    height: 40
                    radius: Theme.radius.fullStatic
                    color: "transparent"
                    border.color: Theme.palette._primary
                    border.width: 1
                    visible: dayCell.isTodayCell
                }

                // Hover — filled circle behind the label
                Rectangle {
                    id: dayCellHover
                    anchors.centerIn: parent
                    width: 40
                    height: 40
                    radius: Theme.radius.fullStatic
                    color: Theme.palette._onSurface
                    opacity: 0

                    Behavior on opacity {
                        NumberAnimation {
                            duration: Theme.motion.expressiveDefaultEffects.duration
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                        }
                    }
                }

                // Day number
                Text {
                    anchors.centerIn: parent
                    text: dayCell.model.day
                    font.pixelSize: 16
                    font.weight: dayCell.isTodayCell ? Font.DemiBold : Font.Normal
                    color: {
                        if (dayCell.isTodayCell)
                            return Theme.palette._primary
                        if (!dayCell.isCurrentMonth)
                            return Theme.palette._outline
                        return Theme.palette._onSurface
                    }

                    Behavior on color {
                        ColorAnimation {
                            duration: Theme.motion.expressiveDefaultEffects.duration
                            easing.type: Easing.BezierSpline
                            easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: dayCellHover.opacity = 0.08
                    onExited: dayCellHover.opacity = 0
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }

    // ─────────────────────────────────────────────────────────────────
    // NavButton — small icon button used for month/year chevrons.
    // Provides a circular hover highlight behind the icon.
    // ─────────────────────────────────────────────────────────────────

    component NavButton: Item {
        id: navBtn

        required property string iconName
        signal clicked()

        width: 24
        height: 24
        anchors.verticalCenter: parent.verticalCenter

        // Hover highlight
        Rectangle {
            id: navBtnHover
            anchors.fill: parent
            radius: Theme.radius.fullStatic
            color: Theme.palette._onSurface
            opacity: 0

            Behavior on opacity {
                NumberAnimation {
                    duration: Theme.motion.expressiveDefaultEffects.duration
                    easing.type: Easing.BezierSpline
                    easing.bezierCurve: Theme.motion.expressiveDefaultEffects.bezierCurve
                }
            }
        }

        Icon {
            anchors.centerIn: parent
            iconName: navBtn.iconName
            iconColor: Theme.palette._onSurfaceVariant
            size: 20
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: navBtnHover.opacity = 0.08
            onExited: navBtnHover.opacity = 0
            onClicked: navBtn.clicked()
            cursorShape: Qt.PointingHandCursor
        }
    }
}
