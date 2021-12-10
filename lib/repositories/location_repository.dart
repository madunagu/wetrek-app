import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:wetrek/models/location.dart';

class LocationRepository {
  StreamController<Location> _locationStreamController = StreamController();

  Stream<Location> get currentLocation => _locationStreamController.stream;
  late final StreamSubscription<Position> positionStream;
  LocationRepository() {
    positionStream = Geolocator.getPositionStream().listen((Position position) {
      //TODO: here perform functions that happen when location
      print(
        position.latitude.toString() + ', ' + position.longitude.toString(),
      );
    });
  }

  Future<Location> getLocation() async {
    return Future.delayed(Duration.zero);
  }

  void dispose() {
    _locationStreamController.close();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
