import { Gdk, Gtk } from "astal/gtk4";
import { bind } from "astal";
import Hyprland from "gi://AstalHyprland";

type WorkspacesProps = {
  monitor: Gdk.Monitor;
};

const Workspaces = ({ monitor }: WorkspacesProps) => {
  const hypr = Hyprland.get_default();

  const monitorName = monitor.get_connector();

  return (
    <box
      cssClasses={["workspaces"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      spacing={2}
    >
      {bind(hypr, "workspaces").as((wss) =>
        wss
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
          .filter((ws) => ws.get_monitor().name === monitorName) // only show workspaces on current monitor
          .sort((a, b) => a.id - b.id)
          .map((ws) => {
            return (
              <button
                valign={Gtk.Align.START}
                halign={Gtk.Align.START}
                cssClasses={bind(hypr, "focusedWorkspace").as((fw) => {
                  let classNames = [];

                  const isActiveWorkspace =
                    ws.monitor.activeWorkspace.id === ws.id;
                  const isFocusedWorkspace = ws === fw;

                  // focused comes first to take priority
                  if (isFocusedWorkspace) {
                    // return ["focused"];
                    classNames.push("focused");
                  }

                  if (isActiveWorkspace) {
                    classNames.push("active");
                  }

                  return classNames;
                })}
                onClicked={() => ws.focus()}
              >
                <label
                  // vexpand={false}
                  // hexpand={false}
                  halign={Gtk.Align.CENTER}
                  valign={Gtk.Align.CENTER}
                  label={ws.id.toString()}
                />
              </button>
            );
          }),
      )}
    </box>
  );
};

export default Workspaces;
