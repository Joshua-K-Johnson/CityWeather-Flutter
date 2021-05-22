import 'package:clima/Location.dart';
import 'package:clima/services/networking.dart';

const apiKey = '4324ab46dcb450b8d9a2a90f6a4562fe';
const openWeatherMapUrl = 'https://api.openweathermap.org/data/2.5';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = new NetworkHelper(
        '$openWeatherMapUrl/forecast?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = new Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = new NetworkHelper(
        '$openWeatherMapUrl/forecast?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    print('Weather Model Made Successfully');
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '😥 It\'s 🍦 time';
    } else if (temp > 20) {
      return '🤔 Time for shorts and 👕';
    } else if (temp < 10) {
      return '🥶 You\'ll need 🧣 and 🧤';
    } else {
      return '😉 Bring a 🧥 just in case';
    }
  }
}
