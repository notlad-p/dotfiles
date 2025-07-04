import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/components"
import "root:/config"

BarButton {
    id: root
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "battery-70"
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "bluetooth"
    }

    Icon {
        size: 16
        iconColor: Colors.white
        iconName: "wifi-4-bar"
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
