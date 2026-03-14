import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.components
import qs.config
import qs.services

BarButton {
    id: root
    marginX: 6
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    property bool hasUnreadNotifs: false

    Icon {
        id: icon
        visible: !root.hasUnreadNotifs
        size: 16
        iconColor: Colors.white
        iconName: "notifications"
    }

    Icon {
        id: iconUnread
        visible: root.hasUnreadNotifs
        size: 16
        raw: true
        iconName: "notifications-unread"
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        // loading: true
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {
                spacing: 12

                NotificationListItem {
                    appIcon: "image://icon/firefox"
                    appName: "Firefox"
                    title: "This is a Browser notification."
                    body: "Your download has completed successfully. The file has been saved to your Downloads folder and is ready to use."
                    timestamp: Date.now() - 180000  // 3 minutes ago
                }

                NotificationListItem {
                    appIcon: "image://icon/firefox"
                    appName: "Firefox"
                    title: "This is a Browser notification with a really long title that should be capped at a certain point."
                    body: "Your download has completed successfully. The file has been saved to your Downloads folder and is ready to use."
                    timestamp: Date.now() - 180000  // 3 minutes ago
                }
                Timer {
                    id: timeAgoTick
                    interval: 1000
                    running: true
                    repeat: true
                    // Toggling this triggers re-evaluation of any binding that reads it
                    property bool tick: false
                    onTriggered: tick = !tick
                }

                Text {

                    text: {
                        // Dependency on tick forces re-evaluation every 60s
                        color: "white";
                        timeAgoTick.tick;
                        return Date.now();

                        // let seconds = (Date.now() - notification.created.getTime()) / 1000;
                        // if (seconds < 60) return "just now";
                        // let minutes = Math.floor(seconds / 60);
                        // if (minutes < 60) return minutes + "m";
                        // let hours = Math.floor(minutes / 60);
                        // if (hours < 24) return hours + "h";
                        // return Math.floor(hours / 24) + "d";
                    }
                }

                Repeater {
                    model: NotificationService.notifications

                    NotificationListItem {
                        required property NotificationService.Notif modelData
                        appIcon: {
                            console.log(modelData?.notification?.created);
                            // console.log(modelData?.notification?.created?.toLocaleTimeString());
                            // console.log(modelData.appIcon)
                            // console.log(modelData.image)
                            if (modelData.appIcon) {
                                return modelData.appIcon;
                            }

                            if (modelData.image) {
                                return modelData.image;
                            }
                        }
                        appName: modelData.appName
                        title: modelData.summary
                        // title: modelData.appName
                        body: modelData.body
                        timestamp: Date.now() - 180000  // 3 minutes ago
                    }
                }

                Repeater {
                    model: NotificationService.notifications
                    Text {
                        required property NotificationService.Notif modelData
                        color: "white"
                        text: {
                            // console.log(modelData)
                            return modelData.notification.id + " : " + modelData.summary + " : " + modelData.timeAgo;
                        }

                        TapHandler {
                            onTapped: {
                                modelData.dismiss();
                            }
                        }
                    }
                }
            }
        }
    }
}
