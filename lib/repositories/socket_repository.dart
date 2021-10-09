import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';

class SocketRepository {
  final _controller = StreamController<Message>.broadcast();
  final AuthenticationRepository authenticationRepository;
  late final String token;
  late final PusherClient _pusher;
  late final Channel _channel;

  SocketRepository({required this.authenticationRepository}) {
    _pusher = new PusherClient(
      "app-key",
      PusherOptions(
        // if local on android use 10.0.2.2
        host: API.host,
        encrypted: false,
        auth: PusherAuth(
          API.host,
          headers: {
            'Authorization': 'Bearer ${authenticationRepository.token}',
          },
        ),
      ),
      enableLogging: true,
    );

    _channel = _pusher.subscribe("private-orders");

    _pusher.onConnectionStateChange((state) {
      log("previousState: ${state?.previousState ?? ''}, currentState: ${state?.currentState ?? ''}");
    });

    _pusher.onConnectionError((error) {
      log("error: ${error?.message ?? ''}");
    });

    _channel.bind('chat-channel', (event) {
      if (event?.data != null) {
        _controller.sink.add(Message.fromJson(jsonDecode(event!.data!)));
      }
    });
  }

  Stream<Message> get messageSubscription {
    return _controller.stream;
  }

  void dispose() {
    _pusher.disconnect();
    _controller.close();
  }
}
