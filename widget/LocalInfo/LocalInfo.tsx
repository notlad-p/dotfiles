import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import DateTime from "components/DateTime";

import Calendar from "./Calendar";
import Weather from "./Weather";

export const LocalInfoWindowName = "localInfoWindow";

const LocalInfo = (gdkmonitor: Gdk.Monitor) => {
  const { TOP } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();

  return (
    <window
      visible={false}
      // visible
      layer={Astal.Layer.TOP}
      marginTop={52}
      name={`${LocalInfoWindowName}-${monitorName}`}
      cssClasses={["local-info-window"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP}
      application={App}
    >
      <box
        vexpand={false}
        hexpand={false}
        valign={Gtk.Align.CENTER}
        halign={Gtk.Align.CENTER}
        vertical
      >
        <box halign={Gtk.Align.CENTER}>
          <DateTime format="%_I" cssClasses={["hour-min", "hour"]} />
          <box cssClasses={["divider"]} />
          <DateTime format="%M" cssClasses={["hour-min", "min"]} />
          <DateTime format="%p" cssClasses={["am-pm"]} />
        </box>

        <Calendar />

        <Weather />
      </box>
    </window>
  );
};

export default LocalInfo;
