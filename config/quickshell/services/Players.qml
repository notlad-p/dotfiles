pragma Singleton
pragma ComponentBehavior: Bound

import QtQml
import QtQml.Models
import Quickshell
import Quickshell.Services.Mpris

import qs.config

Singleton {
    id: root

    property list<MprisPlayer> list: [...Mpris.players.values].sort((a, b) => {
        if (a.isPlaying && !b.isPlaying) {
            return -1; // a (true) comes before b (false)
        }
        if (!a.isPlaying && b.isPlaying) {
            return 1; // b (true) comes before a (false)
        }
        return 0; // Keep original order if isActive values are the same
    })

    property MprisPlayer trackedPlayer: null
    property MprisPlayer activePlayer: trackedPlayer ?? Mpris.players.values[0] ?? null

    function getIconName(identity: string): string {
        if (identity.includes("zen")) {
            return "zen-browser";
        } else if (identity === "Spotify") {
            return "spotify";
        } else if (identity.includes("Mozilla")) {
            return "firefox";
        }

        return "music";
    }

    function getIconColor(identity: string): string {
        if (identity === "Spotify") {
            return "#1ED760";
        } else if (identity.includes("zen") || identity.includes("Mozilla")) {
            return "transparent";
        }

        return Colors.white.toString();
    }

    Instantiator {
        model: Mpris.players

        Connections {
            required property MprisPlayer modelData
            target: modelData

            Component.onCompleted: {
                if (root.trackedPlayer == null || modelData.isPlaying) {
                    root.trackedPlayer = modelData;
                }
            }

            Component.onDestruction: {
                if (root.trackedPlayer == null || !root.trackedPlayer.isPlaying) {
                    for (const player of Mpris.players.values) {
                        if (player.playbackState.isPlaying) {
                            root.trackedPlayer = player;
                            break;
                        }
                    }

                    if (trackedPlayer == null && Mpris.players.values.length != 0) {
                        trackedPlayer = Mpris.players.values[0];
                    }
                }
            }

            function onPlaybackStateChanged() {
                if (root.trackedPlayer !== modelData)
                    root.trackedPlayer = modelData;
            }
        }
    }
}
