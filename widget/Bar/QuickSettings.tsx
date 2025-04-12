
import { Gtk } from "astal/gtk4";

const QuickSettings = () => {
  return (
    <button
      cssClasses={["btn-icon"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box spacing={8}>
        <image iconName="sliders-symbolic" />
      </box>
    </button>
  );
};

export default QuickSettings;
