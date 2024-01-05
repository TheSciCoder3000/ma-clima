import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:test_clima_flutter/screens/location_screen.dart';
import 'package:test_clima_flutter/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    getWeatherData((data) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(data: data);
      }));
    });
  }

  void getWeatherData(Function(String data) navigateFunc) async {
    try {
      Networking networking = Networking();
      final data = await networking.getDataWithLocation();
      navigateFunc(data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          size: 70.0,
          color: Colors.white,
        )
      ),
    );
  }
}
