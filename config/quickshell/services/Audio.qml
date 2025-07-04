pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    // readonly property string sinkIcon: {
    //     (muted) ? "󰝟" : (volume > 0.5) ? "󰕾" : (volume > 0.01) ? "󰖀" : "󰕿";
    // }
    readonly property var sinkMuted: sink?.audio.muted
    // readonly property var sinkVolume: sink?.audio.volume

    readonly property PwNode source: Pipewire.defaultAudioSource
    // readonly property string sourceIcon: (this.sourceMuted) ? "󰍭" : "󰍬"
    readonly property var sourceMuted: source?.audio.muted
    // readonly property var sourceVolume: source?.audio.volume

    readonly property ObjectModel nodes: Pipewire.nodes

    function getVolume(node: PwNode): real {
      return node.audio.volume * 100
    }

    function setVolume(node: PwNode, volume: real) {
      node.audio.volume = volume
    }

    function toggleMute(node: PwNode) {
        node.audio.muted = !node.audio.muted;
    }

    function wheelAction(event: WheelEvent, node: PwNode) {
        if (event.angleDelta.y < 0) {
            node.audio.volume -= 0.01;
        } else {
            node.audio.volume += 0.01;
        }

        if (node.audio.volume > 1.3) {
            node.audio.volume = 1.3;
        }
        if (root.sink.audio.volume < 0) {
            node.audio.volume = 0.0;
        }
    }

    PwObjectTracker {
        objects: [...root.nodes.values.filter(e => e.type === PwNodeType.AudioSink || e.type === PwNodeType.AudioSource)]
    }
}
