pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root
    property int secondsEllapsed: 0
    property bool isRunning: false
    property string timerText: {
        const hh = Math.floor(root.secondsEllapsed / (60 * 60)).toString().padStart(2, "0");
        const mm = Math.floor((root.secondsEllapsed / 60) % 60).toString().padStart(2, "0");
        const ss = (root.secondsEllapsed % 60).toString().padStart(2, "0");

        return `${hh}:${mm}:${ss}`;
    }

    function toggle() {
        root.isRunning = !root.isRunning;
    }

    function reset() {
        root.secondsEllapsed = 0;
    }

    Timer {
        id: stopwatchTimer
        running: root.isRunning
        repeat: true
        interval: 1000
        onTriggered: root.secondsEllapsed++
    }
}
