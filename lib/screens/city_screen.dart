import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_clima_flutter/services/networking.dart';
import 'package:test_clima_flutter/services/weather.dart';
import 'package:test_clima_flutter/utilities/constants.dart';
class CityScreen extends StatefulWidget {
  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String citySearch = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(
                    fontSize: 11.0,
                    height: 1,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Enter a city here",
                    hintStyle: TextStyle(
                      fontSize: 11.0,
                      height: 1,
                    ),
                    icon: Icon(Icons.search),
                    contentPadding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: Colors.white12,
                        width: 0.0
                      )
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: Colors.white12,
                        width: 0.0
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      borderSide: BorderSide(
                        color: Colors.white12,
                        width: 0.0
                      )
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    citySearch = value;
                  }),
                ),
              ),
              TextButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  WeatherModel? weather;
                  print("testing");
                  
                  try {
                    String data = await Networking().getDataWithCity(citySearch);
                    weather = WeatherModel(data);
                  } catch (e) {
                    List<String> data = e.toString().split("-");    // statuscode-errormessage [string format]
                    print(data);
                    weather = WeatherModel(
                      "",
                      error: true,
                      code: data[0],
                      msg: data[1]
                    );
                  }

                  print(weather.error);

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, weather);
                },
                child: const Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
              const SizedBox(height: 40.0),
              if (loading) const SpinKitDoubleBounce(
                size: 70.0,
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
