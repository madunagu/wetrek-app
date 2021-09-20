import 'dart:async';

// import 'package:laravel_echo/laravel_echo.dart';
// import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:wetrek/blocs/chat.bloc.dart';
import 'package:wetrek/blocs/events/chat.event.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/network/api.dart';

class ChatService {
  StreamController<Message> _messagesStreamController = StreamController();
  Stream<Message> get messages => _messagesStreamController.stream;
  final ChatBloc chatBloc;
  final String token;
  ChatService({required this.chatBloc, required this.token}) {
    // Create echo instance
    // PusherOptions options = PusherOptions(
    //   host: API.host,
    //   port: 6001,
    //   encrypted: false,
    // );

    // FlutterPusher pusher = FlutterPusher('app', options, enableLogging: true);

    // Echo echo = new Echo({
    //   'broadcaster': 'socket.io',
    //   'client': pusher,
    //   'auth': {
    //     'headers': {'Authorization': 'Bearer $token'}
    //   }
    // });
    // pusher.on('connect', (_) => print('connect'));
    // pusher.on('disconnect', (_) => print('disconnect'));

    // echo.channel('chat-channel').listen('PublicEvent', _addMessage);
  }

  Future<Notification> getLocation() async {
    return Future.delayed(Duration.zero);
  }

  void _addMessage(e) {
    //TODO: may need to parse the json to a message model...
    chatBloc.add(ChatAdded(message: e));
  }

  void dispose() {
    _messagesStreamController.close();
  }
}
