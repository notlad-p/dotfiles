import { Gtk } from "astal/gtk4";

const SystemInfo = () => {
  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box spacing={10}>
        <image iconName="battery-70-symbolic" />
        <image iconName="bluetooth-symbolic" />
        <image iconName="wifi-4-bar-symbolic" />
      </box>
    </button>
  );
};

export default SystemInfo;
