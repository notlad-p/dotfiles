import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland

import qs.components

RowLayout {
    id: root
    spacing: 6

    required property ShellScreen screen
    property HyprlandMonitor monitor: Hyprland.monitorFor(screen)
    property list<HyprlandWorkspace> screenWorkspaces: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.id === monitor.id && ws.id > 0)
    property list<HyprlandWorkspace> specialWorkspaces: Hyprland.workspaces.values.filter(ws => ws.monitor && ws.monitor.id === monitor.id && ws.id < 0)
    readonly property string activeSpecial: Hyprland.focusedMonitor?.lastIpcObject?.specialWorkspace?.name ?? ""
    readonly property int isActiveSpecialOnMonitor: root.specialWorkspaces.findIndex((workspace) => workspace.name === root.activeSpecial) !== -1

    readonly property real dimmedWorkspaceOpacity: 0.6

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent): void {
            if (["workspace", "moveworkspace", "activespecial", "focusedmon"].includes(event.name)) {
                Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();

            }
        }
    }

    Repeater {
        model: root.screenWorkspaces

        delegate: IconButton {
            id: w1Button
            size: "xs"
            buttonWidth: "wide"
            text: modelData.name
            implicitWidth: 42
            radius: 8
            pressedRadius: 4
            toggled: modelData.active
            opacity: {
              if (root.isActiveSpecialOnMonitor) {
                return root.dimmedWorkspaceOpacity
              }

              return 1
            }
            roundedRight: {
                if (root.specialWorkspaces.length === 0 && screenWorkspaces.length === index + 1) {
                    return true;
                }

                return false;
            }
            onClicked: {
                if (!modelData.active) {
                    modelData.activate();
                }
            }
        }
    }

    Repeater {
        model: root.specialWorkspaces
        delegate: RowLayout {
          spacing: 0
          required property int index
          required property HyprlandWorkspace modelData
          property string name: modelData.name.split(":")[1]
          property bool isKnownSpecial: {
            switch(name) {
              case "browser-scratch":
              case "obsidian-scratch":
                return true
              default:
                return false
            }
          }

          Loader {
            active: isKnownSpecial

            sourceComponent: IconButton {
              visible: {
                switch(name) {
                  case "browser-scratch":
                  case "obsidian-scratch":
                    return true
                  default:
                    return false
                }
              }
              size: "xs"
              buttonWidth: "wide"
              quantizeIconBackground: true
              // TODO: change toggled color to match icon? Or just make it dimmer by adding a property to StyledButton
              rawIcon: true
              iconName: {
                switch(name) {
                  case "browser-scratch":
                    return "apps/firefox"
                  case "obsidian-scratch":
                    return "apps/obsidian"
                  default:
                    return "material/stars-filled"
                }
              }
              toggled: root.activeSpecial === modelData.name
              opacity: {
                if (root.isActiveSpecialOnMonitor && root.activeSpecial !== modelData.name) {
                  return root.dimmedWorkspaceOpacity
                }

                return 1
              }
              implicitWidth: 42
              radius: 8
              pressedRadius: 4
              roundedRight: {
                  if (root.specialWorkspaces.length === index + 1) {
                      return true;
                  }

                  return false;
              }
              onClicked: {
                Hyprland.dispatch(`togglespecialworkspace ${name}`);
              }
            }
          }

          Loader {
            active: !isKnownSpecial

            sourceComponent: StyledButton {
              size: "xs"
              text: name
              toggled: modelData.focused
              radius: 8
              pressedRadius: 4
              roundedRight: {
                  if (root.specialWorkspaces.length === index + 1) {
                      return true;
                  }

                  return false;
              }
              onClicked: {
                Hyprland.dispatch(`togglespecialworkspace ${name}`);
              }
            }
          }


        }
    }
}
