import 'dart:convert';

class WeatherModel {
  late final int id;
  late final String city;
  late final String description;
  late final double temp;
  late final int condition;
  bool error = false;
  String? code, msg;

  WeatherModel(String data, {this.error = false, this.code, this.msg}) {
    if (error) {
      id = 0;
      temp = 0;
      city = "";
      return;
    } 
    id = jsonDecode(data)["id"];
    temp = jsonDecode(data)["main"]["temp"];
    city = jsonDecode(data)["name"];
    condition = jsonDecode(data)["weather"][0]["id"];
  }

  String getWeatherIcon() {

    if (error) return "Error: $code";

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

  String getMessage() {
    if (error) return msg ?? "";
    if (temp > 25) {
      return 'It\'s 🍦 time in $city';
    } else if (temp > 20) {
      return 'Time for shorts and 👕 in $city';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤 in $city';
    } else {
      return 'Bring a 🧥 just in case in $city';
    }
  }
}
