import { App, Gtk, Gdk } from "astal/gtk4";
import { QuickSettingsWindowName } from "../QuickSettings/QuickSettings";

type QuickSettingsProps = {
  monitor: Gdk.Monitor;
};

const QuickSettings = ({ monitor }: QuickSettingsProps) => {
  const monitorName = monitor.get_connector();

  return (
    <button
      cssClasses={["btn-icon"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => {
        App.toggle_window(`${QuickSettingsWindowName}-${monitorName}`);
      }}
    >
      <box spacing={8}>
        <image iconName="sliders-symbolic" />
      </box>
    </button>
  );
};

export default QuickSettings;
