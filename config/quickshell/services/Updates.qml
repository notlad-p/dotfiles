pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property string uptime
    property int arch: 1
    property int aur: 2
    property string icon: arch || aur ? "package-updates" : "package"
    property bool forceUpdate: false

    function forceUpdateRun() {
        root.forceUpdate = true;
        getUpdatesProc.running = true;
    }

    Process {
        id: getUpdatesProc
        command: ["bash", "-c", `${Quickshell.shellRoot}/scripts/updates.sh ${root.forceUpdate ? "true" : "false"}`]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                const {
                    arch,
                    aur
                } = JSON.parse(this.text);
                root.arch = arch;
                root.aur = aur;

                if (root.forceUpdate) {
                    root.forceUpdate = false;
                }
            }
        }
    }

    Timer {
        // update every 30 min
        interval: 1000 * 60 * 30
        running: true
        repeat: true
        onTriggered: getUpdatesProc.running = true
    }
}
