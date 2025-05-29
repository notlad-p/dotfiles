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
      <box spacing={8}>
        <image iconName="notifications-bell" />
      </box>
    </button>
  );
};

export default Notifications;
