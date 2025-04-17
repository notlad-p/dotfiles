import { App, Gdk, Gtk } from "astal/gtk4";
import { AudioSettingsWindowName } from "../AudioSettings/AudioSettings";

type AudioInOutProps = {
  monitor: Gdk.Monitor;
};
const AudioInOut = ({ monitor }: AudioInOutProps) => {
  const monitorName = monitor.get_connector();

  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => {
        // TODO: check if monitor name is null, & send notification
        App.toggle_window(`${AudioSettingsWindowName}-${monitorName}`);
      }}
    >
      <box spacing={10}>
        <image iconName="volume-high-symbolic" />
        <image iconName="mic-off-symbolic" />
      </box>
    </button>
  );
};

export default AudioInOut;
