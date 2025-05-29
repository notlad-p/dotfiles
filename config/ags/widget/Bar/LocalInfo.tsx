import { App, Gdk, Gtk } from "astal/gtk4";
import { LocalInfoWindowName } from "../LocalInfo/LocalInfo";
import DateTime from "components/DateTime";
import { bind } from "astal";
import weather from "services/weather";

const Weather = () => {
  return (
    <box spacing={8}>
      <image
        iconName={bind(weather, "weather").as(
          ({ current }) => current.values.weatherCodeIcon,
        )}
      />
      <label
        label={bind(weather, "weather").as(
          ({ current }) => `${current.values.temperature}°F`,
        )}
      />
    </box>
  );
};

type LocalInfoProps = {
  monitor: Gdk.Monitor;
};

const LocalInfo = ({ monitor }: LocalInfoProps) => {
  const monitorName = monitor.get_connector();

  return (
    <button
      cssClasses={["btn"]}
      vexpand={false}
      hexpand={false}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.CENTER}
      onClicked={() => {
        App.toggle_window(`${LocalInfoWindowName}-${monitorName}`);
      }}
    >
      <box spacing={12}>
        <Weather />
        <DateTime format="%a, %b %d" />
        <DateTime format="%_I:%M %P" />
      </box>
    </button>
  );
};

export default LocalInfo;
