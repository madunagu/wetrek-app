import 'dart:async';

// import 'package:laravel_echo/laravel_echo.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/message.dart';

class NotificationService {
  StreamController<Notification> _notificationStreamController =
      StreamController();
  StreamController<Message> _messagesStreamController = StreamController();
  Stream<Notification> get notification => _notificationStreamController.stream;
  Stream<Message> get messages => _messagesStreamController.stream;
//  late final StreamSubscription<Position> positionStream;
  NotificationService() {
    // Create echo instance
    // Echo echo = new Echo({
    //   'broadcaster': 'socket.io',
    //   // 'client': IO.io,
    // });

// Listening public channel
    // echo.channel('chat-channel').listen('PublicEvent', _addMessage);
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

  void _addMessage(e) {}

  void dispose() {
    _notificationStreamController.close();
    _messagesStreamController.close();
  }
}
