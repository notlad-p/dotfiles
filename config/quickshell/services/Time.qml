pragma Singleton

import Quickshell
import QtQuick

Singleton {
    function format(fmt: string): string {
        return Qt.formatDateTime(clock.date, fmt);
    }

    function getHour(): string {
        return Qt.formatDateTime(clock.date, "h ap").split(" ")[0];
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
