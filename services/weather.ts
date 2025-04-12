import { execAsync, interval } from "astal";
import GObject, { register, property } from "astal/gobject";
import config from "../config";

type IntervalValuesBase = {
  humidity: number;
  temperature: number;
  temperatureApparent: number;
  temperatureApparentMax: number;
  temperatureApparentMin: number;
  temperatureMax: number;
  temperatureMin: number;
  weatherCode: number;
  windDirection: number;
  windSpeed: number;
  precipitationProbability: number;
};

type IntervalValuesDay = IntervalValuesBase & {
  weatherCodeDay: number;
  weatherCodeFullDay: number;
  weatherCodeNight: number;
};

type IntervalItem<T> = {
  startTime: string;
  values: T;
};

type Timeline = {
  timestep: "current" | "1h" | "1d";
  endTime: string;
  startTime: string;
  intervals: IntervalItem<IntervalValuesBase | IntervalValuesDay>[];
};

type ResData = {
  data: {
    timelines: Timeline[];
  };
};

type AdditionalValues = {
  weatherCodeIcon: string;
  weatherCodeDescription: string;
};

type Current = Pick<
  IntervalValuesBase,
  | "humidity"
  | "temperature"
  | "weatherCode"
  | "windSpeed"
  | "precipitationProbability"
> &
  AdditionalValues;
type Hourly = Pick<IntervalValuesBase, "temperature" | "weatherCode"> &
  AdditionalValues;
type Daily = Pick<
  IntervalValuesBase,
  "temperature" | "temperatureMin" | "temperatureMax" | "weatherCode"
> &
  AdditionalValues;

export type WeatherData = {
  current: IntervalItem<Current>;
  hourly: IntervalItem<Hourly>[];
  daily: IntervalItem<Daily>[];
};

enum WeatherCode {
  UNKNOWN = 0,
  CLEAR_SUNNY = 1000,
  MOSTLY_CLEAR = 1100,
  PARTLY_CLOUDY = 1101,
  MOSTLY_CLOUDY = 1102,
  CLOUDY = 1001,
  // Fog
  FOG = 2000,
  LIGHT_FOG = 2100,
  // Rain
  DRIZZLE = 4000,
  LIGHT_RAIN = 4200,
  RAIN = 4001,
  HEAVY_RAIN = 4201,
  // Snow
  FLURRIES = 5001,
  LIGHT_SNOW = 5100,
  SNOW = 5000,
  HEAVY_SNOW = 5101,
  FREEZING_DRIZZLE = 6000 | 6200,
  FREEZING_RAIN = 6001 | 6201,
  // Sleet
  LIGHT_ICE_PELLETS = 7102,
  ICE_PELLETS = 7000,
  HEAVY_ICE_PELLETS = 7101,
  // Thunder storm
  THUNDERSTORM = 8000,
}

const DEFAULT_VALUES: WeatherData = {
  current: {
    startTime: "2025-04-13T16:00:00Z",
    values: {
      humidity: 50,
      temperature: 50,
      weatherCode: 1001,
      weatherCodeIcon: "weather-cloudy-symbolic",
      weatherCodeDescription: "Cloudy",
      windSpeed: 50,
      precipitationProbability: 10,
    },
  },
  hourly: Array(5).fill({
    startTime: "2025-04-13T16:00:00Z",
    values: {
      temperature: 50,
      weatherCode: 1001,
      weatherCodeIcon: "weather-cloudy-symbolic",
      weatherCodeDescription: "Cloudy",
    },
  }),
  daily: Array(3).fill({
    startTime: "2025-04-13T16:00:00Z",
    values: {
      temperature: 50,
      temperatureMax: 50,
      temperatureMin: 50,
      weatherCode: 1000,
      weatherCodeIcon: "weather-cloudy-symbolic",
      weatherCodeDescription: "Cloudy",
    },
  }),
};

const REFRESH_MIN = 10;

@register()
class Weather extends GObject.Object {
  @property(String)
  declare myProp: string;

  @property(Object)
  declare weather: WeatherData;

  @property(String)
  declare city: string;

  private _get_icon(weatherCode: number) {
    switch (weatherCode) {
      case WeatherCode.CLEAR_SUNNY:
        // TODO: add night & day version
        return "weather-clear-day-symbolic";
      case WeatherCode.MOSTLY_CLOUDY ||
        WeatherCode.PARTLY_CLOUDY ||
        WeatherCode.MOSTLY_CLOUDY:
        // TODO: add night & day version
        return "weather-partly-cloudy-day-symbolic";
      case WeatherCode.CLOUDY:
        return "weather-cloudy-symbolic";
      case WeatherCode.FOG || WeatherCode.LIGHT_FOG:
        return "weather-fog-symbolic";
      case WeatherCode.DRIZZLE ||
        WeatherCode.LIGHT_RAIN ||
        WeatherCode.FREEZING_DRIZZLE ||
        WeatherCode.LIGHT_ICE_PELLETS:
        return "weather-drizzle-symbolic";
      case WeatherCode.RAIN ||
        WeatherCode.FREEZING_RAIN ||
        WeatherCode.ICE_PELLETS:
        return "weather-rain-symbolic";
      case WeatherCode.HEAVY_RAIN || WeatherCode.HEAVY_ICE_PELLETS:
        return "weather-heavy-rain-symbolic";
      case WeatherCode.FLURRIES ||
        WeatherCode.LIGHT_SNOW ||
        WeatherCode.SNOW ||
        WeatherCode.HEAVY_SNOW:
        return "weather-snow-symbolic";
      case WeatherCode.THUNDERSTORM:
        return "weather-thunderstorm-symbolic";
      default:
        return "weather-cloudy-symbolic";
    }
  }

  private _get_description(weatherCode: number) {
    switch (weatherCode) {
      case WeatherCode.CLEAR_SUNNY:
        return "Clear, Sunny";
      case WeatherCode.MOSTLY_CLEAR:
        return "Mostly Clear";
      case WeatherCode.PARTLY_CLOUDY:
        return "Partly Cloudy";
      case WeatherCode.MOSTLY_CLOUDY:
        return "Clear, Sunny";
      case WeatherCode.CLOUDY:
        return "Cloudy";
      case WeatherCode.FOG:
        return "Fog";
      case WeatherCode.LIGHT_FOG:
        return "Light Fog";
      case WeatherCode.DRIZZLE:
        return "Drizzle";
      case WeatherCode.LIGHT_RAIN:
        return "Light Rain";
      case WeatherCode.RAIN:
        return "Rain";
      case WeatherCode.HEAVY_RAIN:
        return "Heavy Rain";
      case WeatherCode.FLURRIES:
        return "Flurries";
      case WeatherCode.LIGHT_SNOW:
        return "Light Snow";
      case WeatherCode.SNOW:
        return "Snow";
      case WeatherCode.HEAVY_SNOW:
        return "Heavy Snow";
      case WeatherCode.FREEZING_DRIZZLE:
        return "Freezing Drizzle";
      case WeatherCode.FREEZING_RAIN:
        return "Freezing Rain";
      case WeatherCode.LIGHT_ICE_PELLETS:
        return "Light Sleet";
      case WeatherCode.ICE_PELLETS:
        return "Sleet";
      case WeatherCode.HEAVY_ICE_PELLETS:
        return "Heavy Sleet";
      case WeatherCode.THUNDERSTORM:
        return "Thunderstorm";
      default:
        return "Cloudy";
    }
  }

  // convert weather code to description & icon name
  private _convert_data(
    interval: IntervalItem<IntervalValuesBase | IntervalValuesDay>,
  ) {
    const { startTime, values } = interval;
    const weatherCodeIcon = this._get_icon(values.weatherCode);
    const weatherCodeDescription = this._get_description(values.weatherCode);

    const roundedValues = { ...values };
    for (const key in roundedValues) {
      if (typeof roundedValues[key] === "number") {
        roundedValues[key] = Math.round(roundedValues[key]);
      }
    }

    return {
      startTime,
      values: {
        ...roundedValues,
        weatherCodeIcon,
        weatherCodeDescription,
      },
    };
  }

  private async _get_location() {
    // const locationRes = await execAsync("curl ipinfo.io")
    const locationRes = await execAsync("curl http://ip-api.com/json");

    const { city, lat, lon } = JSON.parse(locationRes);

    this.city = city;

    return { lat, lon };
  }

  private async _fetch_weather() {
    try {
      const { lat, lon } = await this._get_location();
      const res = await execAsync([
        "bash",
        "-c",
        `~/.config/ags/scripts/weather.sh ${lat} ${lon} ${config.tomorrowApiKey}`,
      ]);

      const {
        data: { timelines },
      }: ResData = JSON.parse(res);

      // default data
      let formattedData: WeatherData = { ...DEFAULT_VALUES };

      for (let i = 0; i < timelines.length; i++) {
        if (timelines[i].timestep === "1h") {
          // split into 3 hour intervals from current time
          const threeHourIntervals = [];
          for (let j = 3; j <= 15; j += 3) {
            threeHourIntervals.push(
              this._convert_data(timelines[i].intervals[j]),
            );
          }

          formattedData.hourly = threeHourIntervals;
        }

        if (timelines[i].timestep === "1d") {
          // @ts-ignore
          formattedData.daily = timelines[i].intervals.map((intv) =>
            this._convert_data(intv),
          );
        }

        if (timelines[i].timestep === "current") {
          formattedData.current = this._convert_data(timelines[i].intervals[0]);
        }
      }

      this.weather = formattedData;
    } catch (error) {
      console.error(error);
    }
  }

  constructor() {
    super();

    this.weather = DEFAULT_VALUES;

    interval(1000 * 60 * REFRESH_MIN, async () => {
      await this._fetch_weather();
    });
  }
}

const weather = new Weather();
export default weather;
