import QtQuick
import QtQuick.Layouts

import Quickshell
import Quickshell.Widgets

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

    Icon {
        id: icon
        size: 16
        iconColor: Colors.white
        iconName: "sliders"
    }

    LazyLoader {
        id: selectorLoader
        loading: false
        onActiveAsyncChanged: selectorLoader.item.toggle()

        BarPopup {
            id: popup
            parentContainer: root

            Column {
                spacing: 8
                WrapperItem {
                    implicitWidth: 300
                    StyledText {
                        text: "test"
                    }
                }

                Grid {
                    columns: 2
                    spacing: 8

                    // NOTE: DialogButton / ToggleDialogButton
                    ToggleDialogButton {}
                    ToggleDialogButton {}
                }

                Grid {
                    columns: 4
                    spacing: 8
                    IconButton {
                        buttonWidth: "wide"
                        size: "md"
                        rounded: true
                        iconName: "material/stars-filled"
                        onClicked: toggled = !toggled
                    }

                    IconButton {
                        buttonWidth: "wide"
                        size: "md"
                        rounded: true
                        iconName: "material/stars-filled"
                        onClicked: toggled = !toggled
                    }

                    IconButton {
                        buttonWidth: "wide"
                        size: "md"
                        rounded: true
                        iconName: "material/stars-filled"
                        onClicked: toggled = !toggled
                    }

                    IconButton {
                        buttonWidth: "wide"
                        size: "md"
                        rounded: true
                        iconName: "material/stars-filled"
                        onClicked: toggled = !toggled
                    }
                }

                Column {
                    spacing: 8

                    MaterialSlider {
                        size: "md"
                        iconName: "material/volume-up"
                        inactiveIconName: "material/volume-off"
                    }

                    MaterialSlider {
                        size: "md"
                        iconName: "material/brightness"
                        inactiveIconName: "material/brightness"
                    }
                }

                // ConnectedButtonGroup {
                //
                //     ConnectedButton {
                //         size: "xs"
                //         iconName: "material/stars-filled"
                //         onClicked: toggled = !toggled
                //     }
                //
                //     ConnectedButton {
                //         size: "xs"
                //         iconName: "material/stars-filled"
                //         onClicked: toggled = !toggled
                //     }
                //
                //     ConnectedButton {
                //         size: "xs"
                //         iconName: "material/stars-filled"
                //         onClicked: toggled = !toggled
                //     }
                // }

                StyledButton {
                    id: barButton
                    size: "xs"
                    rounded: true
                    // iconName: "volume-high"
                    text: "Sun, Sep 14   3:42pm"
                    onClicked: barButton.toggled = !barButton.toggled
                }

                StyledButton {
                    id: barIconsButton
                    size: "xs"
                    rounded: true
                    // iconName: "volume-high"
                    text: "Sun, Sep 14   3:42pm"
                    contentItem: RowLayout {
                        WrapperRectangle {
                            color: "transparent"
                            Icon {
                                size: 20
                                iconColor: barIconsButton.textColor
                                iconName: "material/stars-filled"
                            }
                        }
                        // IconButton {
                        //     buttonWidth: "narrow"
                        //     size: "xs"
                        //     rounded: true
                        //     iconName: "material/stars-filled"
                        //     onClicked: toggled = !toggled
                        // }
                    }
                    // onClicked: toggled = !barButton.toggled
                }

                // Row {
                //     spacing: 12
                //
                //     IconButton {
                //       id: icnButton
                //       iconName: "material/stars-filled"
                //       onClicked: icnButton.toggled = !icnButton.toggled
                //     }
                //
                //     IconButton {
                //         // iconName: "volume-high"
                //         iconName: "material/stars-filled"
                //         buttonWidth: "narrow"
                //     }
                //     IconButton {
                //         iconName: "volume-high"
                //         buttonWidth: "wide"
                //     }
                // }
                //
                // Row {
                //     spacing: 12
                //
                //     IconButton {
                //         id: roundIcnBtn
                //         rounded: true
                //         iconName: "volume-high"
                //         onClicked: roundIcnBtn.toggled = !roundIcnBtn.toggled
                //     }
                //
                //     IconButton {
                //         rounded: true
                //         iconName: "volume-high"
                //         buttonWidth: "narrow"
                //     }
                //     IconButton {
                //         rounded: true
                //         iconName: "volume-high"
                //         buttonWidth: "wide"
                //     }
                // }

                // StyledButton {
                //     size: "sm"
                //     rounded: true
                //     iconName: "volume-high"
                // }
                //
                // StyledButton {
                //     size: "sm"
                //     rounded: true
                //     iconName: "volume-high"
                //     text: "Hello there"
                // }
                //

                // WrapperItem {
                //   Layout.fillWidth: true
                //   Row {
                //
                //
                //   }
                // }

                // RowLayout {
                //     spacing: 20
                //
                //     GridLayout {
                //         columns: 3
                //         rowSpacing: 8
                //         columnSpacing: 8
                //
                //         SettingsToggleButton {
                //             toggled: true
                //             iconName: "wifi-off"
                //             toggledIconName: "wifi-4-bar"
                //         }
                //
                //         SettingsToggleButton {
                //             toggled: false
                //             iconName: "bluetooth-off"
                //             toggledIconName: "bluetooth"
                //         }
                //
                //         SettingsToggleButton {
                //             toggled: false
                //             iconName: "airplane-mode-off"
                //             toggledIconName: "airplane-mode"
                //         }
                //
                //         SettingsToggleButton {
                //             toggled: false
                //             iconName: "caffeine-off"
                //             toggledIconName: "caffeine"
                //         }
                //
                //         SettingsToggleButton {
                //             toggled: false
                //             iconName: "notifications-off"
                //             toggledIconName: "notifications"
                //         }
                //
                //         SettingsToggleButton {
                //             toggled: true
                //             iconName: "window"
                //             toggledIconName: "window"
                //         }
                //     }
                //
                //     Rectangle {
                //         Layout.fillHeight: true
                //         Layout.preferredWidth: 2
                //         color: Colors.black700
                //     }
                //
                //     GridLayout {
                //         columns: 3
                //         rowSpacing: 8
                //         columnSpacing: 8
                //
                //         SettingsToolButton {
                //             iconName: "screenshot"
                //         }
                //
                //         SettingsToolButton {
                //             iconName: "record"
                //         }
                //
                //         SettingsToolButton {
                //             iconName: "internet-globe"
                //         }
                //
                //         SettingsToolButton {
                //             iconName: "color-picker"
                //         }
                //
                //         SettingsToolButton {
                //             iconName: "search"
                //         }
                //
                //         SettingsToolButton {
                //             iconName: "folder"
                //         }
                //     }
                // }
                //
                // WrapperRectangle {
                //     Layout.fillWidth: true
                //     // Layout.preferredHeight: 150
                //     margin: 8
                //     radius: 8
                //     color: Colors.black800
                //
                //     ColumnLayout {
                //         spacing: 16
                //
                //         SettingsSlider {
                //             iconName: "volume-high"
                //         }
                //         SettingsSlider {
                //             iconName: "microphone-high"
                //         }
                //         SettingsSlider {
                //             iconName: "brightness-high"
                //         }
                //     }
                // }

                // ColumnLayout {
                //   spacing: 8
                //
                // WrapperRectangle {
                //     Layout.fillWidth: true
                //     // Layout.preferredHeight: 150
                //     margin: 8
                //     radius: 8
                //     color: Colors.black800
                //
                //       SettingsSlider {
                //         iconName: "volume-high"
                //       }
                // }
                //
                // WrapperRectangle {
                //     Layout.fillWidth: true
                //     // Layout.preferredHeight: 150
                //     margin: 8
                //     radius: 8
                //     color: Colors.black800
                //
                //       SettingsSlider {
                //         iconName: "volume-high"
                //       }
                // }
                //
                // WrapperRectangle {
                //     Layout.fillWidth: true
                //     // Layout.preferredHeight: 150
                //     margin: 8
                //     radius: 8
                //     color: Colors.black800
                //
                //       SettingsSlider {
                //         iconName: "volume-high"
                //       }
                // }
                // }
            }
        }
    }
}
