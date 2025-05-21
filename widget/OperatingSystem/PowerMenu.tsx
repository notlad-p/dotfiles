import { exec } from "astal";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { OperatingSystemWindowName } from "./OperatingSystem";

type ButtonProps = {
  icon: string;
  action: () => void;
};
const Button = ({ icon, action }: ButtonProps) => {
  return (
    <button
      onClicked={action}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.END}
      cssClasses={[
        "p-3",
        "bg-black-700",
        "hover:bg-black-600",
        "transition",
        "duration-200",
      ]}
    >
      <image iconName={icon} cssClasses={["icon-6"]} />
    </button>
  );
};

export const PowerMenuWindowName = "powerMenu";
const PowerMenu = (gdkmonitor: Gdk.Monitor) => {
  const monitorName = gdkmonitor.get_connector();

  const buttons = [
    {
      icon: "power",
      action: () => {
        exec(["bash", "-c", "systemctl poweroff || loginctl poweroff"]);
      },
    },
    {
      icon: "restart",
      action: () => {
        exec(["bash", "-c", "systemctl reboot || loginctl reboot"]);
      },
    },
    {
      icon: "lock-screen",
      action: () => {
        // TODO: fix windows not closing until unlocked
        App.toggle_window(`${OperatingSystemWindowName}-${monitorName}`);
        App.toggle_window(`${PowerMenuWindowName}-${monitorName}`);
        // NOTE: hypridle must be running for this to work
        exec(["bash", "-c", "loginctl lock-session"]);
      },
    },
    {
      icon: "logout",
      action: () => {
        exec([
          "bash",
          "-c",
          "pkill Hyprland || pkill sway || pkill niri || loginctl terminate-user $USER",
        ]);
      },
    },
    {
      icon: "sleep",
      action: () => {
        exec(["bash", "-c", "systemctl suspend || loginctl suspend"]);
      },
    },
    {
      icon: "hibernate",
      action: () => {
        exec(["bash", "-c", "systemctl hibernate || loginctl hibernate"]);
      },
    },
    // TODO: buy wifi plug with api & call api here
    // For now, use hyprctl for two main monitors
    // {
    //   icon: "monitor-off",
    //   action: () => {},
    // },
  ];

  return (
    <window
      layer={Astal.Layer.TOP}
      marginTop={52}
      marginLeft={8}
      name={`${PowerMenuWindowName}-${monitorName}`}
      cssClasses={["bg-black-900", "rounded-lg", "text-white-500", "p-4"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      application={App}
      defaultWidth={10}
      defaultHeight={10}
      overflow={Gtk.Overflow.HIDDEN}
    >
      <box spacing={8}>
        {buttons.map((props) => (
          <Button {...props} />
        ))}
      </box>
    </window>
  );
};

export default PowerMenu;
