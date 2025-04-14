import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import weather from "services/weather";

const formatHourlyTime = (isoDate: string) => {
  const date = new Date(isoDate);
  let hours = date.getHours();
  const ampm = hours >= 12 ? "pm" : "am";

  hours = hours % 12;
  hours = hours ? hours : 12; // the hour '0' should be '12'
  return `${hours} ${ampm}`;
};

const Weather = () => {
  return bind(weather, "weather").as(({ current, hourly, daily }) => (
    <box vertical cssClasses={["weather"]}>
      <box cssClasses={["location-container"]}>
        <image iconName="location-pin-symbolic" />
        <label valign={Gtk.Align.CENTER} label={bind(weather, "city")} />
      </box>

      <centerbox
        cssClasses={["current"]}
        vexpand={false}
        valign={Gtk.Align.CENTER}
      >
        <box
          vertical
          valign={Gtk.Align.CENTER}
          halign={Gtk.Align.START}
          cssClasses={["current-weather"]}
        >
          <box>
            <image
              cssClasses={["weather-icon"]}
              iconName={bind(weather, "weather").as(
                ({ current }) => current.values.weatherCodeIcon,
              )}
            />
            <label
              cssClasses={["temp-text"]}
              label={`${current.values.temperature}°`}
            />
          </box>

          <box>
            <label
              cssClasses={["weather-text"]}
              label={current.values.weatherCodeDescription}
            />
          </box>

          <box cssClasses={["high-low"]} valign={Gtk.Align.CENTER}>
            <image iconName="arrow-down-custom-symbolic" />
            <label label={`${daily[0].values.temperatureMin}°`} />
            <image
              iconName="arrow-up-custom-symbolic"
              cssClasses={["high-icon"]}
            />
            <label label={`${daily[0].values.temperatureMax}°`} />
          </box>
        </box>

        <box />

        <box
          vertical
          valign={Gtk.Align.CENTER}
          halign={Gtk.Align.CENTER}
          cssClasses={["current-stats"]}
          marginTop={8}
          spacing={8}
        >
          <box cssClasses={["stat-item"]}>
            <image iconName="precipitation-chance-symbolic" />
            <label
              label={`Precipitation: ${current.values.precipitationProbability}%`}
            />
          </box>

          <box cssClasses={["stat-item"]}>
            <image iconName="wind-symbolic" />
            <label label={`Wind: ${current.values.windSpeed} mph`} />
          </box>

          <box>
            <image iconName="humidity-symbolic" />
            <label label={`Humidity: ${current.values.humidity}%`} />
          </box>
        </box>
      </centerbox>

      <box cssClasses={["hourly-weather"]} spacing={24}>
        {hourly.map((item) => (
          <box vertical hexpand>
            <label label={formatHourlyTime(item.startTime)} />
            <image iconName="weather-cloudy-symbolic" />
            <label label={`${Math.round(item.values.temperature)}`} />
          </box>
        ))}
      </box>

      <box vertical spacing={10} cssClasses={["days-container"]}>
        {daily.slice(1, 4).map((day) => {
          const weekDayNum = new Date(day.startTime).getDay();
          const days = [
            "Sunday",
            "Monday",
            "Tuesday",
            "Wednesday",
            "Thursday",
            "Friday",
            "Saturday",
          ];

          return (
            <box cssClasses={["day-weather"]}>
              <label label={`${days[weekDayNum]}`} />

              <box hexpand halign={Gtk.Align.END}>
                <image iconName={day.values.weatherCodeIcon} />
                <label
                  cssClasses={["min-temp"]}
                  label={`${day.values.temperatureMin}°F`}
                />
                <label
                  halign={Gtk.Align.END}
                  label={`${day.values.temperatureMax}°F`}
                />
              </box>
            </box>
          );
        })}
      </box>
    </box>
  ));
};

export default Weather;
