import { App, Astal, Gdk, Gtk } from "astal/gtk4";

export const OperatingSystemWindowName = "operatingSystem";

const OperatingSystem = (gdkmonitor: Gdk.Monitor) => {
  const { TOP, LEFT } = Astal.WindowAnchor;

  const monitorName = gdkmonitor.get_connector();

  return (
    <window
      namespace="astal-widget-audio-settings"
      visible
      layer={Astal.Layer.TOP}
      marginTop={52}
      marginLeft={8}
      name={`${OperatingSystemWindowName}-${monitorName}`}
      cssClasses={[
        "bg-black-900",
        "rounded-lg",
        "text-white-500",
        "p-4",
        // "min-w-sm",
      ]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.IGNORE}
      anchor={TOP | LEFT}
      application={App}
      defaultWidth={10}
      defaultHeight={10}
      overflow={Gtk.Overflow.HIDDEN}
    >
      <label label="OS Widget" />
    </window>
  );
};

export default OperatingSystem;
