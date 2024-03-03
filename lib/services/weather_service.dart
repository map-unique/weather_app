import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const _baseUrl = "http://api.weatherapi.com/v1";
  final String apiKey;

  WeatherService(this.apiKey);


  Future<Weather> getWeather(String cityName) async {
    // http://api.weatherapi.com/v1/forecast.json?key=1edd88b8741d4d84b30181810242402&q=London&days=3&aqi=no&alerts=no

    final uri =
        Uri.parse("$_baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3&aqi=no");

    // print(uri);

    final response = await http.get(uri);

    // print(response.body);

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    print("permission : $permission");

    if (permission == LocationPermission.denied) {
      permission == await Geolocator.requestPermission();

    } else {
      print('not access');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("position : $position");

    List <Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    print("placeMarks : $placeMarks");

    String? cityName = placeMarks[0].locality;

    print ("$cityName 2");

    return cityName ?? "Tehran";

  }
}
