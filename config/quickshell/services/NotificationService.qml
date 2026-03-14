pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

/*
 * Usage
 * ─────
 * Popups:   Connections { target: NotificationService
 *                         function onIncoming(n) { popup.show(n) } }
 * List:     Repeater { model: NotificationService.notifications }
 * Clear:    NotificationService.clearAll()
 */
Singleton {
    id: root

    // ─── Public API ──────────────────────────────────────────────────────

    /// All active notifications wrapped with a persistent uid + timestamp.
    property list<Notif> notifications: []

    /// Raw server access for anything not proxied by the wrapper.
    readonly property alias server: notifServer

    /// Fired for genuinely new notifications. Ones carried across a
    /// Quickshell reload (`lastGeneration`) are added to the list silently.
    signal incoming(Notif notif)

    function clearAll(): void {
        // Copy first — dismiss() → closed → splices the live array
        for (const n of [...root.notifications]) n.dismiss();
    }

    // ─── Wrapper type ────────────────────────────────────────────────────
    // Quickshell's Notification.id resets to 1 on every launch, so we
    // wrap each one with a uid that is monotonic across reboots.

    component Notif: QtObject {
        required property Notification notification
        required property int  uid        // unique across restarts
        required property date timestamp  // receipt time

        /// Human-readable age ("just now", "3 minutes ago", …).
        /// Reading root._timeTick creates a dependency so the binding
        /// re-evaluates every time the shared timer fires.
        readonly property string timeAgo: {
            root._timeTick; // dependency only — value unused

            const sec = Math.floor((Date.now() - timestamp.getTime()) / 1000);
            if (sec < 60) return "just now";

            const fmt = (n, unit) => `${n} ${unit}${n === 1 ? "" : "s"} ago`;

            const min = Math.floor(sec / 60);
            if (min < 60) return fmt(min, "minute");

            const hr = Math.floor(min / 60);
            if (hr < 24) return fmt(hr, "hour");

            const day = Math.floor(hr / 24);
            if (day < 7) return fmt(day, "day");

            const wk = Math.floor(day / 7);
            if (day < 30) return fmt(wk, "week");

            const mo = Math.floor(day / 30);
            if (mo < 12) return fmt(mo, "month");

            return fmt(Math.floor(day / 365), "year");
        }

        // ── passthrough properties ──
        readonly property string appName:                notification.appName
        readonly property string appIcon:                notification.appIcon
        readonly property string summary:                notification.summary
        readonly property string body:                   notification.body
        readonly property string image:                  notification.image
        readonly property string desktopEntry:           notification.desktopEntry
        readonly property string urgency:                NotificationUrgency.toString(notification.urgency)
        readonly property real   expireTimeout:          notification.expireTimeout
        readonly property bool   isTransient:            notification.transient   // 'transient' is a reserved word
        readonly property bool   resident:               notification.resident
        readonly property bool   hasActionIcons:         notification.hasActionIcons
        readonly property bool   hasInlineReply:         notification.hasInlineReply
        readonly property string inlineReplyPlaceholder: notification.inlineReplyPlaceholder
        readonly property var    actions:                notification.actions
        readonly property var    hints:                  notification.hints

        // ── passthrough methods ──
        function dismiss(): void                     { notification.dismiss(); }
        function expire(): void                      { notification.expire(); }
        function sendInlineReply(text: string): void { notification.sendInlineReply(text); }

        // ── json serialization ──
        function serialize(): var {
            return {
                uid, timestamp: timestamp.toISOString(),
                appName, appIcon, summary, body, image, desktopEntry, urgency,
            };
        }
    }

    // ─── timeAgo driver ──────────────────────────────────────────────────
    // One timer for the whole service; every Notif's timeAgo depends on
    // _timeTick, so one increment refreshes them all. Sleeps when the
    // list is empty.

    property int _timeTick: 0

    Timer {
        interval: 30 * 1000          // 30 s — max staleness for minute granularity
        repeat: true
        running: root.notifications.length > 0
        onTriggered: root._timeTick++
    }

    // ─── Persistence ─────────────────────────────────────────────────────
    // Declared before the server so _nextUid is populated before any
    // notification can arrive. blockLoading makes the read synchronous.

    property int _nextUid: 0

    readonly property string _statePath: {
        const base = Quickshell.env("XDG_STATE_HOME")
                  || `${Quickshell.env("HOME")}/.local/state`;
        return `${base}/quickshell/notifications.json`;
    }

    FileView {
        id: stateFile
        path: root._statePath
        blockLoading: true
        watchChanges: false

        onLoaded: {
            try {
                root._nextUid = JSON.parse(text()).nextUid ?? 0;
            } catch (e) {
                console.warn("NotificationService: bad state file, resetting:", e);
            }
        }
        onLoadFailed: err => { /* first run — no file yet */ }
    }

    function _save(): void {
        stateFile.setText(JSON.stringify({
            nextUid: root._nextUid,
            notifications: root.notifications.map(n => n.serialize()),
        }, null, 2));
    }

    // ─── Notification Server ─────────────────────────────────────────────

    NotificationServer {
        id: notifServer

        // Enable every capability that defaults to false
        actionsSupported:        true
        actionIconsSupported:    true
        bodyHyperlinksSupported: true
        bodyImagesSupported:     true
        bodyMarkupSupported:     true
        imageSupported:          true
        inlineReplySupported:    true
        persistenceSupported:    true
        // keepOnReload: false

        onNotification: raw => {
            raw.tracked = true;

            const wrapped = notifComponent.createObject(root, {
                notification: raw,
                uid:          root._nextUid++,
                timestamp:    new Date(),
            });

            root.notifications.push(wrapped);

            raw.closed.connect(() => {
                const i = root.notifications.indexOf(wrapped);
                if (i !== -1) root.notifications.splice(i, 1);
                wrapped.destroy();
                root._save();
            });

            root._save();

            if (!raw.lastGeneration)
                root.incoming(wrapped);
        }
    }

    Component { id: notifComponent; Notif {} }
}
