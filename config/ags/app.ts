import { App } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";

import Bar from "./widget/Bar/Bar";
import LocalInfo from "./widget/LocalInfo/LocalInfo";
import AudioSettings from "./widget/AudioSettings/AudioSettings";
import OperatingSystem from "./widget/OperatingSystem/OperatingSystem";
import PowerMenu from "./widget/OperatingSystem/PowerMenu";
import QuickSettings from "./widget/QuickSettings/QuickSettings";

import style from "./styles/index.scss";
import handleMonitorChange from "./utils/monitor-change";

// creates widget windows on each screen
export const createWindows = () => {
  const windows = [
    Bar,
    LocalInfo,
    AudioSettings,
    OperatingSystem,
    PowerMenu,
    QuickSettings,
  ];

  for (const gdkmonitor of App.get_monitors()) {
    windows.map((win) => win(gdkmonitor));
  }
};

App.start({
  css: style,
  icons: "./icons",
  main() {
    const hyprland = Hyprland.get_default();

    createWindows();

    // handle monitor add / remove by refreshing windows
    hyprland.connect("monitor-added", (_, monitor: Hyprland.Monitor) => {
      console.log("Add monitor: ", monitor.get_name());
      handleMonitorChange();
    });

    hyprland.connect("monitor-removed", (_, monitorId: number) => {
      console.log("Remove monitor id: ", monitorId);
      handleMonitorChange();
    });
  },
});
