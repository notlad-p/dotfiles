import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import qs.components
import qs.config

RowLayout {
    id: root
    spacing: 0
    property bool isOpen: false
    function toggle() {
        isOpen = !isOpen;
        console.log(isOpen);
    }

    ClippingWrapperRectangle {
        color: "transparent"

        implicitWidth: root.isOpen ? layout.implicitWidth : 0

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }

        WrapperRectangle {
            id: layout
            color: "transparent"
            rightMargin: 8
            visible: width > 0 && height

            RowLayout {
                spacing: 4

                Repeater {
                    model: SystemTray.items.values
                    delegate: BarButton {
                        id: trayAppButton
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
                        IconImage {
                            implicitSize: 16
                            source: {
                                let icon = modelData.icon;
                                if (icon.includes("?path=")) {
                                    const [name, path] = icon.split("?path=");
                                    icon = `file://${path}/${name.slice(name.lastIndexOf("/") + 1)}`;
                                }
                                return icon;
                            }
                        }

                        LazyLoader {
                            id: selectorLoader
                            loading: false
                            onActiveAsyncChanged: selectorLoader.item.toggle()

                            BarPopup {
                                id: popup
                                parentContainer: trayAppButton

                                ColumnLayout {
                                    spacing: 12
                                    QsMenuOpener {
                                        id: menuOpener
                                        menu: modelData.menu
                                    }
                                    Repeater {
                                        model: menuOpener.children
                                        delegate: WrapperRectangle {
                                            color: "transparent"
                                            border.width: 1
                                            border.color: "white"
                                            ColumnLayout {
                                                StyledText {
                                                    text: modelData.text
                                                }
                                                StyledText {
                                                    text: modelData.hasChildren
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    BarButton {
        id: trayButton
        marginX: 6
        background: Colors.black900
        backgroundHover: Colors.black700
        onClicked: () => {
            root.toggle();
        }

        Icon {
            id: icon
            size: 16
            iconColor: Colors.white
            iconName: "caret-bar"

            transform: Rotation {
                origin.x: 8
                origin.y: 8
                axis {
                    x: 0
                    y: 1
                    z: 0
                }
                angle: root.isOpen ? 180 : 0
                Behavior on angle {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
}
