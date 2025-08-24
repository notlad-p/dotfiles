import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.services
import qs.components
import qs.config

BarButton {
    id: root
    onClicked: () => {
        if (!selectorLoader.active) {
            selectorLoader.activeAsync = true;
        } else {
            selectorLoader.item.toggle();
        }
    }

    RowLayout {
        spacing: 8
        Layout.alignment: Qt.AlignVCenter

        Icon {
            size: 16
            iconColor: "#1ED760"
            iconName: "spotify"
        }

        StyledText {
            text: "Reptillia - The Strokes"
            color: Colors.white
            font.weight: Font.Bold
        }
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

                Text {
                    text: "Hello there"
                    color: "white"
                }
                Text {
                    text: "Hello there"
                    color: "white"
                }
                Text {
                    text: "Hello there"
                    color: "white"
                }
                Text {
                    text: "Hello there"
                    color: "white"
                }
                Text {
                    text: "Hello there"
                    color: "white"
                }
            }
        }
    }
}
