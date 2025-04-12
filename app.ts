import { App, Widget } from "astal/gtk4";
import style from "./styles/index.scss";
import Bar from "./widget/Bar/Bar";
import LocalInfo from "./widget/LocalInfo/LocalInfo";

App.start({
  css: style,
  icons: "./icons",
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(LocalInfo);
  },
});
