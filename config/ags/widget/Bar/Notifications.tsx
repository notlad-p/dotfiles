import { Gtk } from "astal/gtk4";

const Notifications = () => {
  return (
    <button
      cssClasses={["btn-icon"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
    >
      <box spacing={8} cssClasses={[]}>
        <image
          iconName="package-updates"
          cssClasses={["notif-icon", "text-white-500"]}
        />
      </box>
    </button>
  );
};

export default Notifications;
