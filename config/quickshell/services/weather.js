function makeRequest(method, url) {
  return new Promise(function (resolve, reject) {
    let xhr = new XMLHttpRequest();

    xhr.onreadystatechange = function (response) {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        // if (xhr.status >= 200 && xhr.status < 300) {
        if (xhr.status === 200) {
          // console.log(xhr.responseText);
          resolve(xhr.responseText);
        } else {
          reject({
            status: xhr.status,
            statusText: xhr.statusText,
          });
        }
      }
    };

    xhr.open(method, url);
    xhr.send();
  });
}

function getWeather() {
  const ipApiUrl = "http://ip-api.com/json/";

  let weatherData = {
    lastUpdate: null,
    city: null,
    data: null,
  };

  makeRequest("GET", ipApiUrl)
    .then((locationJson) => {
      // const { lat, lon, city } = JSON.parse(locationJson);
      return JSON.parse(locationJson);
      // console.log(lat, lon, city);
    })
    .then(({ lat, lon, city }) => {
      // console.log("City: ", city);

      const weatherApiUrl = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&daily=weather_code,temperature_2m_max,temperature_2m_min&hourly=temperature_2m,weather_code&current=temperature_2m,relative_humidity_2m,precipitation,wind_speed_10m,weather_code&timezone=America%2FNew_York&forecast_days=3&wind_speed_unit=mph&temperature_unit=fahrenheit&precipitation_unit=inch`;
      makeRequest("GET", weatherApiUrl).then((weatherJson) => {
        const data = JSON.parse(weatherJson);
        weatherData = {
          lastUpdate: Date.now(),
          city,
          data,
        };
        console.log("Weather data: ", data.utc_offset_seconds);
        // return {
        //   lastUpdate: Date.now(),
        //   city,
        //   data,
        // };
      });
    });

  return weatherData;
}
