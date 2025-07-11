pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "weather.js" as WeatherScript

// Link for editing api url:
// https://open-meteo.com/en/docs?latitude=40.7128&longitude=74.006&forecast_days=3&hourly=temperature_2m,weather_code&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&timezone=America%2FNew_York&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&temperature_unit=fahrenheit&wind_speed_unit=mph&precipitation_unit=inch

Singleton {
    id: root
    property real maxCacheAge: 1000 * 60 * 30 // 30 min
    property string city: cacheAdapter.city
    property string errorMessage: ""

    // TODO: create `current`, `hourly`, and `daily` root properties to process & store data for UI
    // - create weather codes to icons function
    property var current: {
        if (cacheAdapter.data) {
            const currentData = cacheAdapter.data.current;
            const currentUnits = cacheAdapter.data.current_units;
            const icon = getIcon(currentData.weather_code);

            return {
                icon: getIcon(currentData.weather_code),
                description: getDescription(currentData.weather_code),
                temperature: `${Math.round(currentData.temperature_2m)}${currentUnits.temperature_2m}`,
                humidity: `${currentData.relative_humidity_2m}${currentUnits.relative_humidity_2m}`,
                windSpeed: `${Math.round(currentData.wind_speed_10m)} ${currentUnits.wind_speed_10m}`
            };
        }

        return {
            icon: getIcon(0),
            description: getDescription(0),
            temperature: `70°F`,
            humidity: `15%`,
            windSpeed: `5 mp/h`
        };
    }

    property var hourly: {
        if (cacheAdapter.data) {
            const hourlyData = cacheAdapter.data.hourly;
            const hourlyUnits = cacheAdapter.data.hourly_units;

            const timeArr = cacheAdapter.data.hourly.time;
            const tempArr = cacheAdapter.data.hourly.temperature_2m;
            const weatherCodeArr = cacheAdapter.data.hourly.weather_code;

            const formattedData = [];

            const now = new Date();
            const hourlyStartIndex = timeArr.findIndex(dateTime => {
                const dt = new Date(dateTime);
                return now.getDate() === dt.getDate() && now.getHours() === dt.getHours();
            });

            for (let i = 1; i < 6; i++) {
                const idx = hourlyStartIndex + i * 3;
                formattedData.push({
                    hour: Qt.formatDateTime(new Date(timeArr[idx]), "h ap"),
                    icon: getIcon(weatherCodeArr[idx]),
                    temperature: `${Math.round(tempArr[idx])}${hourlyUnits.temperature_2m}`
                });
            }

            return formattedData;
        }

        return new Array(5).fill({
            hour: "3 pm",
            icon: "weather-clear-day",
            temperature: "70°F"
        });
    }

    property real minDailyTemp: 75
    property real maxDailyTemp: 92
    property real precipitationProb: 10

    property var daily: {
        if (cacheAdapter.data) {
            const dailyData = cacheAdapter.data.daily;
            const dailyUnits = cacheAdapter.data.daily_units;

            const timeArr = cacheAdapter.data.daily.time;
            const minTempArr = cacheAdapter.data.daily.temperature_2m_min;
            const maxTempArr = cacheAdapter.data.daily.temperature_2m_max;
            const weatherCodeArr = cacheAdapter.data.daily.weather_code;

            precipitationProb = cacheAdapter.data.daily.precipitation_probability_max[0];

            const formattedData = [];

            let smallestMinTemp = 1000;
            let largestMaxTemp = 0;

            for (let i = 0; i < timeArr.length; i++) {
                const minTemp = Math.round(minTempArr[i]);
                const maxTemp = Math.round(maxTempArr[i]);

                if (minTemp < smallestMinTemp) {
                    minDailyTemp = minTemp;
                }

                if (maxTemp > largestMaxTemp) {
                    maxDailyTemp = maxTemp;
                }

                const weekdayDate = new Date(timeArr[i]);
                weekdayDate.setMinutes(weekdayDate.getMinutes() + weekdayDate.getTimezoneOffset());
                // console.log(new Date(timeArr[i]).getTimezoneOffset());

                formattedData.push({
                    weekday: Qt.formatDateTime(weekdayDate, "dddd"),
                    icon: getIcon(weatherCodeArr[i]),
                    lowTemp: minTemp,
                    highTemp: maxTemp,
                    lowTempText: `${minTemp}${dailyUnits.temperature_2m_min}`,
                    highTempText: `${maxTemp}${dailyUnits.temperature_2m_max}`
                });
            }

            return formattedData;
        }

        return new Array(3).fill({
            weekday: "Wednesday",
            icon: "weather-clear-day",
            lowTemp: 76,
            highTemp: 88,
            lowTempText: "76°F",
            highTempText: "88°F"
        });
    }

    readonly property var weatherCodeEnum: {
        "CLEAR": 0,
        "MAINLY_CLEAR": 1,
        "PARTLY_CLOUDY": 2,
        "OVERCAST": 3,
        "FOG": 45,
        "RIME_FOG": 48,
        "LIGHT_DRIZZLE": 51,
        "MODERATE_DRIZZLE": 53,
        "DENSE_DRIZZLE": 55,
        "LIGHT_FREEZING_DRIZZLE": 56,
        "DENSE_FREEZING_DRIZZLE": 57,
        "SLIGHT_RAIN": 61,
        "MODERATE_RAIN": 63,
        "HEAVY_RAIN": 65,
        "LIGHT_FREEZING_RAIN": 66,
        "HEAVY_FREEZING_RAIN": 67,
        "SLIGHT_SNOW_FALL": 71,
        "MODERATE_SNOW_FALL": 73,
        "HEAVY_SNOW_FALL": 75,
        "SNOW_GRAINS": 77,
        "SLIGHT_RAIN_SHOWERS": 80,
        "MODERATE_RAIN_SHOWERS": 81,
        "VIOLENT_RAIN_SHOWERS": 82,
        "SLIGHT_SNOW_SHOWERS": 85,
        "HEAVY_SNOW_SHOWERS": 86,
        "THUNDERSTORM": 95,
        "THUNDERSTORM_SLIGHT_HAIL": 96,
        "THUNDERSTORM_HEAVY_HAIL": 99
    }

    function getIcon(weatherCode, isDaytime = true) {
        switch (weatherCode) {
        case weatherCodeEnum.CLEAR:
            // TODO: add night & day version
            return "weather-clear-day";
        case weatherCodeEnum.MAINLY_CLEAR || weatherCodeEnum.PARTLY_CLOUDY:
            // TODO: add night & day version
            return "weather-partly-cloudy-day";
        case weatherCodeEnum.OVERCAST:
            return "weather-cloudy";
        case weatherCodeEnum.FOG || weatherCodeEnum.RIME_FOG:
            return "weather-fog";
        case weatherCodeEnum.LIGHT_DRIZZLE || weatherCodeEnum.MODERATE_DRIZZLE || weatherCodeEnum.DENSE_DRIZZLE || weatherCodeEnum.LIGHT_FREEZING_DRIZZLE || weatherCodeEnum.DENSE_FREEZING_DRIZZLE:
            return "weather-drizzle";
        case weatherCodeEnum.SLIGHT_RAIN || weatherCodeEnum.MODERATE_RAIN || weatherCodeEnum.LIGHT_FREEZING_RAIN:
            return "weather-rain";
        case weatherCodeEnum.HEAVY_RAIN || weatherCodeEnum.HEAVY_FREEZING_RAIN:
            return "weather-heavy-rain";
        case weatherCodeEnum.SLIGHT_SNOW_FALL || weatherCodeEnum.MODERATE_SNOW_FALL || weatherCodeEnum.HEAVY_SNOW_FALL || weatherCodeEnum.SNOW_GRAINS || weatherCodeEnum.SLIGHT_SNOW_SHOWERS || weatherCodeEnum.HEAVY_SNOW_SHOWERS:
            return "weather-snow";
        case weatherCodeEnum.SLIGHT_RAIN_SHOWERS || weatherCodeEnum.MODERATE_RAIN_SHOWERS:
            return "weather-showers";
        case weatherCodeEnum.VIOLENT_RAIN_SHOWERS:
            return "weather-heavy-rainstorm";
        case weatherCodeEnum.THUNDERSTORM || weatherCodeEnum.THUNDERSTORM_SLIGHT_HAIL || weatherCodeEnum.THUNDERSTORM_HEAVY_HAIL:
            return "weather-thunderstorm";
        default:
            return "weather-cloudy";
        }
    }

    function getDescription(weatherCode, isDaytime = true) {
        switch (weatherCode) {
        case weatherCodeEnum.CLEAR:
            return "Clear";
        case weatherCodeEnum.MAINLY_CLEAR:
            return "Mostly Clear";
        case weatherCodeEnum.PARTLY_CLOUDY:
            return "Partly Cloudy";
        case weatherCodeEnum.OVERCAST:
            return "Overcast";
        case weatherCodeEnum.FOG:
            return "Fog";
        case weatherCodeEnum.RIME_FOG:
            return "Rime Fog";
        case weatherCodeEnum.LIGHT_DRIZZLE || weatherCodeEnum.MODERATE_DRIZZLE || weatherCodeEnum.DENSE_DRIZZLE || weatherCodeEnum.LIGHT_FREEZING_DRIZZLE || weatherCodeEnum.DENSE_FREEZING_DRIZZLE:
            return "Drizzle";
        case weatherCodeEnum.SLIGHT_RAIN || weatherCodeEnum.LIGHT_FREEZING_RAIN:
            return "Light Rain";
        case weatherCodeEnum.MODERATE_RAIN:
            return "Rain";
        case weatherCodeEnum.HEAVY_RAIN || weatherCodeEnum.HEAVY_FREEZING_RAIN:
            return "Heavy Rain";
        case weatherCodeEnum.SLIGHT_SNOW_FALL || weatherCodeEnum.SNOW_GRAINS || weatherCodeEnum.SLIGHT_SNOW_SHOWERS:
            return "Light Snow";
        case weatherCodeEnum.MODERATE_SNOW_FALL:
            return "Snow";
        case weatherCodeEnum.HEAVY_SNOW_FALL || weatherCodeEnum.HEAVY_SNOW_SHOWERS:
            return "Heavy Snow";
        case weatherCodeEnum.SLIGHT_RAIN_SHOWERS:
            return "Light Rain Showers";
        case weatherCodeEnum.MODERATE_RAIN_SHOWERS:
            return "Rain Showers";
        case weatherCodeEnum.VIOLENT_RAIN_SHOWERS:
            return "Heavy Rain Showers";
        case weatherCodeEnum.THUNDERSTORM || weatherCodeEnum.THUNDERSTORM_SLIGHT_HAIL || weatherCodeEnum.THUNDERSTORM_HEAVY_HAIL:
            return "Thunderstorm";
        default:
            return "Overcast";
        }
    }

    function checkCacheInvalid(): bool {
        return cacheAdapter.lastUpdate === 0 || Date.now() - cacheAdapter.lastUpdate > root.maxCacheAge;
    }

    function makeRequest(method, url) {
        return new Promise(function (resolve, reject) {
            let xhr = new XMLHttpRequest();

            xhr.onreadystatechange = function (response) {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    // if (xhr.status >= 200 && xhr.status < 300) {
                    if (xhr.status === 200) {
                        resolve(xhr.responseText);
                    } else {
                        reject({
                            status: xhr.status,
                            statusText: xhr.statusText
                        });
                    }
                }
            };

            xhr.open(method, url);
            xhr.send();
        });
    }

    function getWeather() {
        if (!checkCacheInvalid() || errorMessage !== "") {
            console.log("weather cache valid, using cache");
            return;
        }

        errorMessage = "";

        const ipApiUrl = "http://ip-api.com/json/";

        makeRequest("GET", ipApiUrl).then(locationJson => {
            const {
                lat,
                lon,
                city,
                timezone
            } = JSON.parse(locationJson);
            const temperatureUnit = Qt.locale().measurementSystem === Locale.MetricSystem ? "celsius" : "fahrenheit";
            const windSpeedUnit = Qt.locale().measurementSystem === Locale.MetricSystem ? "kmh" : "mph";
            const precipitationUnit = Qt.locale().measurementSystem === Locale.MetricSystem ? "mm" : "inch";

            const weatherApiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&daily=weather_code,temperature_2m_max,temperature_2m_min,precipitation_probability_max&hourly=temperature_2m,weather_code&current=temperature_2m,relative_humidity_2m,wind_speed_10m,weather_code&timezone=${encodeURIComponent("America/New_York")}&forecast_days=4&wind_speed_unit=${windSpeedUnit}&temperature_unit=${temperatureUnit}&precipitation_unit=${precipitationUnit}`;

            makeRequest("GET", weatherApiUrl).then(weatherJson => {
                const data = JSON.parse(weatherJson);

                cacheAdapter.lastUpdate = Date.now();
                cacheAdapter.city = city;
                cacheAdapter.data = data;
                console.log(city);
            }).catch(err => {
                errorMessage = "Failed to fetch weather data";
                console.log(err);
            });
        }).catch(err => {
            errorMessage = "Failed to fetch location data";
            console.log(err);
        });
    }

    FileView {
        id: cacheFile
        path: Quickshell.cachePath("weather/weather_cache.json")
        watchChanges: true
        onFileChanged: this.reload()
        onAdapterUpdated: writeAdapter()
        onLoadFailed: error => {
            if (error === FileViewError.FileNotFound) {
                console.log("File not found");
                createCacheProc.running = true;
                this.reload();
            }
        }

        onLoaded: {
            // after loading cache, start update timer if not already running
            if (!updateTimer.running) {
                updateTimer.running = true;
            }
        }

        JsonAdapter {
            id: cacheAdapter
            property string city
            property real lastUpdate
            property var data

            // property JsonObject data: JsonObject {
            //     property JsonObject current_units: JsonObject {
            //         property string temperature_2m
            //     }
            // }
        }
    }

    Process {
        id: createCacheProc
        running: false
        command: ["bash", "-c", `mkdir -p ${Quickshell.cachePath("weather")} && touch -a ${Quickshell.cachePath("weather/weather_cache.json")}`]
    }

    Timer {
        id: updateTimer
        interval: root.maxCacheAge // Update in line with max cache age
        running: false
        repeat: true
        triggeredOnStart: true
        onTriggered: root.getWeather()
    }
}
