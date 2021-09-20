import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:laravel_echo/laravel_echo.dart';
import 'package:wetrek/blocs/events/chat.event.dart';
import 'package:wetrek/blocs/states/chat.state.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Repository repository;
  final String token;

  StreamController<Message> _messagesStreamController = StreamController();
  Stream<Message> get messages => _messagesStreamController.stream;

  ChatBloc({
    required this.repository,
    required this.token,
  }) : super(const ChatState()) {
    {
      // // Create echo instance
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
  }

  void dispose() {
    _messagesStreamController.close();
  }

  //TODO: work on navigation in infinite list
  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatFetched) {
      yield await _mapPostFetchedToState(state);
    }
    if (event is ChatAdded) {
      yield await _mapSocketAdditionToState(state, event);
    }
  }

  Future<ChatState> _mapPostFetchedToState(ChatState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == ChatStatus.initial) {
        final Paginated<Model> paginatedList = await repository.list(
          Parameters(
            page: 0,
            length: 20,
            q: '',
          ),
        );

        return state.copyWith(
          status: ChatStatus.success,
          models: paginatedList.data,
          hasReachedMax: false,
        );
      }
      final Paginated<Model> paginatedList = await repository.list(
        Parameters(
          page: 0,
          length: 20,
          q: '',
        ),
      );
      return paginatedList.data.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ChatStatus.success,
              models: List.of(state.models)..addAll(paginatedList.data),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: ChatStatus.failure);
    }
  }

  Future<ChatState> _mapSocketAdditionToState(
      ChatState state, ChatAdded event) async {
    try {
      return state.copyWith(
        status: ChatStatus.success,
        models: List.of(state.models)..insert(0, event.message),
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: ChatStatus.failure);
    }
  }

  void _addMessage(e) {
    //TODO: may need to parse the json to a message model...
    this.add(ChatAdded(message: e));
  }

  @override
  Stream<Transition<ChatEvent, ChatState>> transformEvents(
    Stream<ChatEvent> events,
    TransitionFunction<ChatEvent, ChatState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
