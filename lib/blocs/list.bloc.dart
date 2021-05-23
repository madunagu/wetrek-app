import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/repositories/trek_repository.dart';

enum Method {
  GET,
  POST,
  PUT,
  DELETE,
}

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc({
    @required this.feedType,
    @required this.resource,
    this.method = Method.GET,
    this.params,
  }) : assert(resource != null);
  final String feedType;
  final String resource;
  final Method method;
  final dynamic params;
  @override
  ListState get initialState => ListInitial();
  //TODO: work on navigation in infinite list
  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    final currentState = state;
    if (event is ListFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ListInitial) {
          final ServerResponse serverResponse = await _fetchList(0, 20);
          final models = TrekRepository.list();
          yield ListSuccess(
            models: serverResponse.data,
            totalPages: serverResponse.totalPages,
            currentPage: serverResponse.currentPage,
          );
          return;
        }
        if (currentState is ListSuccess) {
          final ServerResponse serverResponse =
              await _fetchList(currentState.currentPage + 1, 20);
          yield ListSuccess(
            models: currentState.models + serverResponse.data,
            totalPages: serverResponse.totalPages,
            currentPage: serverResponse.currentPage,
          );
        }
      } catch (_) {
        log(_.toString());
        yield ListFailure();
      }
    }
  }

  @override
  Stream<Transition<ListEvent, ListState>> transformEvents(
    Stream<ListEvent> events,
    TransitionFunction<ListEvent, ListState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  bool _hasReachedMax(ListState state) =>
      state is ListSuccess && state.currentPage >= state.totalPages;
}
