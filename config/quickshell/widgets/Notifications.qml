import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.components
import qs.config

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
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            ColumnLayout {
                spacing: 12

                StyledText {
                    text: "Hello there"
                    color: "white"
                }
                StyledText {
                    text: "Hello there"
                    color: "white"
                }
                StyledText {
                    text: "Hello there"
                    color: "white"
                }
                StyledText {
                    text: "Hello there"
                    color: "white"
                }
                StyledText {
                    text: "Hello there"
                    color: "white"
                }
            }
        }
    }
}
