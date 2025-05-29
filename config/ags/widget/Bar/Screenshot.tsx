import { Gtk } from "astal/gtk4";

const Screenshot = () => {
  return (
    <button
      cssClasses={["btn-icon"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <image iconName="screenshot-symbolic" />
    </button>
  );
};

export default Screenshot;
