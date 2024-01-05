import 'package:flutter/material.dart';
import 'package:test_clima_flutter/screens/city_screen.dart';
import 'package:test_clima_flutter/services/location.dart';
import 'package:test_clima_flutter/services/networking.dart';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, required this.data});
  final String data;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late WeatherModel weather;
  bool error = false;

  @override
  void initState() {
    super.initState();
    weather = WeatherModel(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      final network = Networking();
                      final location = Location();
                      await location.getLocation();
                      final data = await network.getDataWithLocation();
                      print(data);
                      setState(() {
                        weather = WeatherModel(data);
                      });
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      WeatherModel? data = await Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const CityScreen())
                      );

                      if (data == null) return;
                      setState(() {
                        weather = data;
                      });
                    }, 
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              weather.error ? 
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Error: ${weather.code}", style: const TextStyle(fontSize: 70.0)),
                )
                :
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        '${weather.temp.toInt()}°',
                        style: kTempTextStyle,
                      ),
                      Text(
                        weather.getWeatherIcon(),
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  weather.getMessage(),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
