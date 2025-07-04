pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string uptime

    Process {
        id: dateProc
        command: ["uptime", "-r"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const timeInSeconds = this.text.split(" ")[1];
                let outStr = "";

                const days = Math.floor(timeInSeconds / 60 / 60 / 24);
                if (days > 0) {
                    outStr += `${days}d `;
                }

                const hours = Math.floor(timeInSeconds / 60 / 60 % 24);
                if (hours > 0) {
                    outStr += `${hours}h `;
                }

                const mins = Math.floor(timeInSeconds / 60 % 60);
                outStr += `${mins}m`;

                root.uptime = outStr;
            }
        }
    }

    Timer {
        interval: 30 * 1000
        running: true
        repeat: true
        onTriggered: dateProc.running = true
    }
}
