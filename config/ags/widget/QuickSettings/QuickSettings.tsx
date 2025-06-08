import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import ToggleButton from "./ToggleButton";
import { bind, exec, Variable } from "astal";
import Network from "gi://AstalNetwork";
import Bluetooth from "gi://AstalBluetooth";

export const QuickSettingsWindowName = "quickSettings";

const QuickSettings = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();

  const network = Network.get_default();
  const bluetooth = Bluetooth.get_default();

  const toggleButtons = [
    [
      {
        toggled: bind(network.wifi, "enabled"),
        iconOn: "wifi-4-bar-dark",
        iconOff: "wifi-off-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // toggle wifi
          network.wifi.set_enabled(!network.wifi.get_enabled());
        },
      },
      {
        toggled: bind(bluetooth, "isPowered"),
        iconOn: "bluetooth-dark",
        iconOff: "bluetooth-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // toggle bluetooth
          bluetooth.toggle();
        },
      },
      {
        toggled: bind(Variable(false)),
        iconOn: "airplane-mode-dark",
        iconOff: "airplane-mode-off-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle airplane mode (wifi, bluetooth, etc.)
        },
      },
      {
        toggled: bind(Variable(false)),
        iconOn: "notifications-bell-dark",
        iconOff: "notifications-bell-off-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle mic mute
        },
      },
    ],
    [
      {
        toggled: bind(Variable(false)),
        iconOn: "volume-high-dark",
        iconOff: "volume-mute-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle volume mute
        },
      },
      {
        toggled: bind(Variable(false)),
        iconOn: "microphone-high-dark",
        iconOff: "microphone-mute-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle mic mute
        },
      },
      {
        toggled: bind(Variable(false)),
        iconOn: "window-titlebar-dark",
        iconOff: "window-titlebar-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle window titlebars
        },
      },
      {
        toggled: bind(Variable(false)),
        iconOn: "idle-clock-dark",
        iconOff: "idle-clock-opaque",
        onClicked: (_btn: Gtk.Button) => {
          // TODO: toggle hypridle
          // TODO: use subprocess
          // exec(["bash", "-c", "pkill hypridle || hypridle"]);
        },
      },
    ],
  ];

  return (
    <window
      layer={Astal.Layer.TOP}
      destroyWithParent
      visible
      marginTop={52}
      marginRight={8}
      name={`${QuickSettingsWindowName}-${monitorName}`}
      cssClasses={["bg-black-900", "rounded-lg", "text-white-500", "p-4"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | RIGHT}
      application={App}
      defaultWidth={10}
      defaultHeight={10}
      overflow={Gtk.Overflow.HIDDEN}
    >
      <box vertical>
        <label label="Quick Settings" />
        <box vertical spacing={8}>
          {toggleButtons.map((row) => (
            <box spacing={8}>
              {row.map(({ toggled, iconOn, iconOff, onClicked }) => (
                <ToggleButton
                  toggled={toggled}
                  iconOn={iconOn}
                  iconOff={iconOff}
                  onClicked={onClicked}
                />
              ))}
            </box>
          ))}
        </box>
      </box>
    </window>
  ) as Astal.Window;
};

export default QuickSettings;
