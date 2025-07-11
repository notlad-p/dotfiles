import QtQuick
import QtQuick.Layouts
import Quickshell

import "root:/components"
import "root:/config"

BarButton {
    id: root
    marginX: 6
    background: Colors.black900
    backgroundHover: Colors.black700
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    Icon {
        id: icon
        size: 16
        iconColor: Colors.white
        iconName: "caret-bar"
        // opacity: 0.8
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
