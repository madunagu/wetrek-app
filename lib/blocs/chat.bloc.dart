import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laravel_echo/laravel_echo.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:wetrek/blocs/events/chat.event.dart';
import 'package:wetrek/blocs/states/chat.state.dart';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
// import 'package:wetrek/pusher/pusher.dart';
import 'package:wetrek/repositories/message_repository.dart';
import 'package:wetrek/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wetrek/repositories/socket_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final MessageRepository repository;
  final SocketRepository socketRepository;
  Parameters params;

  late final StreamSubscription<Message> messagesStreamSubscription;

  ChatBloc({
    required this.repository,
    required this.socketRepository,
    this.params = const Parameters(),
  }) : super(const ChatState()) {
    {
      messagesStreamSubscription =
          socketRepository.messageSubscription.listen((event) {
        this.add(ChatAdded(message: event));
      });
    }
  }

  void dispose() {
    messagesStreamSubscription.cancel();
  }


  @override
  Stream<ChatState> mapEventToState(ChatEvent event) async* {
    if (event is ChatFetched) {
      yield await _mapPostFetchedToState(state, event);
    }
    if (event is ChatAdded) {
      yield await _mapSocketAdditionToState(state, event);
    }
  }

  Future<ChatState> _mapPostFetchedToState(
      ChatState state, ChatFetched event) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == ChatStatus.initial) {
        final Paginated<Model> paginatedList = await repository.getMessages(
          params.copyWith(
            page: 0,
            length: 20,
            q: event.query ?? '',
          ),
        );

        return state.copyWith(
          status: ChatStatus.success,
          models: paginatedList.data,
          hasReachedMax: paginatedList.pagination.isLastPage(),
        );
      }
      final Paginated<Model> paginatedList = await repository.getMessages(
        params.copyWith(
          page: state.pagination.currentPage + 1,
          length: 20,
          q: event.query ?? '',
        ),
      );

      return state.copyWith(
        status: ChatStatus.success,
        models: event.query != null
            ? List.of(paginatedList.data)
            : List.of(state.models)
          ..addAll(paginatedList.data),
        hasReachedMax: paginatedList.pagination.isLastPage(),
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
