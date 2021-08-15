import 'dart:async';

import 'package:wetrek/models/index.dart';

class NotificationService {
  StreamController<Notification> _notificationStreamController = StreamController();
  Stream<Notification> get notification => _notificationStreamController.stream;
//  late final StreamSubscription<Position> positionStream;
  NotificationService() {
//    positionStream = Geolocator.getPositionStream().listen((Position position) {
//      //TODO: here perform functions that happen when location
//      print(
//        position.latitude.toString() + ', ' + position.longitude.toString(),
//      );
//    });
  }

  Future<Notification> getLocation() async {
    return Future.delayed(Duration.zero);
  }

  void dispose() {
    _notificationStreamController.close();
  }


}
