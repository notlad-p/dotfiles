import { App, Astal, Gtk, Gdk } from "astal/gtk4";

import AudioInOut from "./AudioInOut";
import Workspaces from "./Workspaces";
import Media from "./Media";
import LocalInfo from "./LocalInfo";
import SysTray from "./SysTray";
import Screenshot from "./Screenshot";
import Stopwatch from "./Stopwatch";
import SystemInfo from "./SystemInfo";
import QuickSettings from "./QuickSettings";
import Notifications from "./Notifications";
import { OperatingSystemWindowName } from "../OperatingSystem/OperatingSystem";
import { PowerMenuWindowName } from "../OperatingSystem/PowerMenu";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;
  const monitorName = gdkmonitor.get_connector();

  return (
    <window
      namespace="astal-bar"
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssName="centerbox">
        <box hexpand halign={Gtk.Align.START}>
          <button
            cssClasses={["btn-icon", "blue"]}
            vexpand={false}
            hexpand={false}
            valign={Gtk.Align.CENTER}
            halign={Gtk.Align.CENTER}
            onClicked={() => {
              // close power menu if it's visible
              const powerMenuWin = App.get_window(
                `${PowerMenuWindowName}-${monitorName}`,
              );
              if (powerMenuWin?.get_visible()) {
                App.toggle_window(`${PowerMenuWindowName}-${monitorName}`);
              }

              App.toggle_window(`${OperatingSystemWindowName}-${monitorName}`);
            }}
          >
            <image iconName="arch-symbolic" />
          </button>

          <Workspaces monitor={gdkmonitor} />
        </box>

        <box spacing={8}>
          <Media />
          <LocalInfo monitor={gdkmonitor} />
        </box>

        <box hexpand halign={Gtk.Align.END} spacing={8}>
          <SysTray />
          <Screenshot />
          <Stopwatch />
          <AudioInOut monitor={gdkmonitor} />
          <SystemInfo />
          <Notifications />
          <QuickSettings monitor={gdkmonitor} />
        </box>
      </centerbox>
    </window>
  );
}
