
import 'package:geolocator/geolocator.dart';

class Location {
  double longitude = 0;
  double latitude = 0;

  Future<void> getLocation() async {
    try {
      await Geolocator.requestPermission();
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

      longitude = pos.longitude;
      latitude = pos.latitude;
    } catch (e) {
      print("Error: getting location");
      print(e);
    }

  }
}