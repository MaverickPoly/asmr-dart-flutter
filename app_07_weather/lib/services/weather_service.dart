import 'dart:convert';

import 'package:app_07_weather/models/weather_model.dart';
import 'package:geocoding/geocoding.dart';
import "package:http/http.dart" as http;
import "package:geolocator/geolocator.dart";

class WeatherService {
  final String _apiKey = "API";

  Future<Placemark?> getLocation() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    // Get Current Position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      return place;
    } else {
      return null;
    }
  }

  Future<WeatherModel?> getWeather(String city) async {
    var response = await http.get(
      Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_apiKey&units=metric",
      ),
    );
    if (response.statusCode != 200) {
      return null;
    }
    var jsonData = jsonDecode(response.body);
    var weatherData = WeatherModel(
      city: jsonData["name"],
      temp: jsonData["main"]["temp"],
      description: jsonData["weather"][0]["description"],
    );
    return weatherData;
  }
}
