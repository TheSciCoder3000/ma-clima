import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:test_clima_flutter/services/location.dart';

class Networking {
  String apiKey = "3ec8394e5735d5afca5131c983a124cf";
  double temp = 0;
  double longitude = 0;
  double latitude = 0;
  late String data, city, description;
  int id = 0;

  Future<String> getDataWithCity(String city) async {
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");
    Response res = await get(url);
    data = res.body;

    if (res.statusCode == 200) {
      return data;
    } else if (res.statusCode == 400) {
      throw ErrorDescription("400-Nothing to search");
    } else if (res.statusCode == 404) {
      throw ErrorDescription("404-Not found");
    } else {
      throw ErrorDescription("${res.statusCode}-Something went wrong");
    }
  }

  Future<String> getDataWithLocation() async {
    Location location = Location();
    await location.getLocation();
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric");
    Response res = await get(url);
    data = res.body;

    if (res.statusCode == 200) {
      return data;
    } else {
      throw Exception("HTTP GET Request Failed, Status Code: ${res.statusCode}");
    }
  }
}