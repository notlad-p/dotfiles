import { Gtk } from "astal/gtk4";

const AudioInOut = () => {
  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box spacing={10}>
        <image iconName="volume-high-symbolic" />
        <image iconName="mic-off-symbolic" />
      </box>
    </button>
  );
};

export default AudioInOut;
