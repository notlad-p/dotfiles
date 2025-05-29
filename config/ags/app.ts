import { App } from "astal/gtk4";
import style from "./styles/index.scss";

import Bar from "./widget/Bar/Bar";
import LocalInfo from "./widget/LocalInfo/LocalInfo";
import AudioSettings from "./widget/AudioSettings/AudioSettings";
import OperatingSystem from "./widget/OperatingSystem/OperatingSystem";
import PowerMenu from "./widget/OperatingSystem/PowerMenu";

App.start({
  css: style,
  icons: "./icons",
  main() {
    const windows = [Bar, LocalInfo, AudioSettings, OperatingSystem, PowerMenu];

    windows.map((win) => App.get_monitors().map(win));
  },
});
