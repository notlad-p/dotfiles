import { App } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";

import Bar from "./widget/Bar/Bar";
import LocalInfo from "./widget/LocalInfo/LocalInfo";
import AudioSettings from "./widget/AudioSettings/AudioSettings";
import OperatingSystem from "./widget/OperatingSystem/OperatingSystem";
import PowerMenu from "./widget/OperatingSystem/PowerMenu";
import QuickSettings from "./widget/QuickSettings/QuickSettings";

import style from "./styles/index.scss";
import { timeout } from "astal";

App.start({
  css: style,
  icons: "./icons",
  main() {
    const windows = [
      Bar,
      LocalInfo,
      AudioSettings,
      OperatingSystem,
      PowerMenu,
      QuickSettings,
    ];

    const hyprland = Hyprland.get_default();

    for (const gdkmonitor of App.get_monitors()) {
      windows.map((win) => win(gdkmonitor));
    }

    // handle monitor add / remove by refreshing windows
    hyprland.connect("monitor-added", (_, monitor: Hyprland.Monitor) => {
      console.log("ADD");
      console.log(monitor.get_name());

      App.get_windows().forEach((window) => window?.destroy());

      timeout(2000, () => {
        for (const gdkmonitor of App.get_monitors()) {
          windows.map((win) => win(gdkmonitor));
        }
      });
    });

    hyprland.connect(
      "monitor-removed",
      (hypr: Hyprland.Hyprland, monitorId: number) => {
        console.log("REMOVE");
        console.log(monitorId);

        App.get_windows().forEach((window) => window?.destroy());

        timeout(2000, () => {
          for (const gdkmonitor of App.get_monitors()) {
            windows.map((win) => win(gdkmonitor));
          }
        });
      },
    );
  },
});
