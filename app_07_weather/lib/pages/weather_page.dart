import 'package:app_07_weather/models/weather_model.dart';
import 'package:app_07_weather/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  Placemark? location;
  WeatherModel? weather;
  WeatherService service = WeatherService();
  late Future<void> weatherFuture;

  @override
  void initState() {
    super.initState();
    weatherFuture = fetchWeather();
  }

  Future<void> fetchWeather() async {
    final locationRes = await service.getLocation();
    if (locationRes == null) return;
    final weatherRes = await service.getWeather(locationRes.locality!);
    setState(() {
      location = locationRes;
      weather = weatherRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather App"), centerTitle: true),
      body: Center(
        child: FutureBuilder(
          future: weatherFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (location == null ||
                weather == null ||
                snapshot.hasError) {
              return Text(
                "Error getting location!",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  weather!.city,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 18),
                Text("${weather!.temp}°C", style: TextStyle(fontSize: 30)),
                SizedBox(height: 8),
                Text(weather!.description, style: TextStyle(fontSize: 28)),
              ],
            );
          },
        ),
      ),
    );
  }
}
