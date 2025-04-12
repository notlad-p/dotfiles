import { Gtk } from "astal/gtk4";

const Media = () => {
  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box spacing={8}>
        <image iconName="spotify-symbolic" cssClasses={["icon-lg"]} />
        <label label="Reptilia - The Strokes" />
      </box>
    </button>
  );
};

export default Media;
