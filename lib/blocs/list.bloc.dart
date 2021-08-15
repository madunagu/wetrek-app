import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/repositories/repository.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc({
    required this.repository,
  }) : super(ListInitial());
  final Repository repository;

  //TODO: work on navigation in infinite list
  @override
  Stream<ListState> mapEventToState(ListEvent event) async* {
    final currentState = state;
    if (event is ListFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ListInitial) {
          yield ListProgress();
          final Paginated<Model> paginatedList = await repository.list(
            Parameters(
              page: 0,
              length: 20,
              q: event.query ?? '',
            ),
          );

          yield ListSuccess(
            models: paginatedList.data,
            totalPages: paginatedList.pagination.totalPages,
            currentPage: paginatedList.pagination.currentPage,
          );
        }

        if (currentState is ListSuccess) {
          yield ListProgress();
          final Paginated<Model> paginatedList = await repository.list(
            Parameters(
              page: currentState.currentPage + 1,
              length: 20,
              q: event.query?? '',
            ),
          );

          yield ListSuccess(
            models: currentState.models + paginatedList.data,
            totalPages: paginatedList.pagination.totalPages,
            currentPage: paginatedList.pagination.currentPage,
          );
        }
      } catch (_) {
        log(_.toString());
        yield ListFailure();
      }
    }
  }

//   @override
//   Stream<Transition<ListEvent, ListState>> transformEvents(
//     Stream<ListEvent> events,
//     TransitionFunction<ListEvent, ListState> transitionFn,
//   ) {
//     return super.transformEvents(
//       events.debounceTime(const Duration(milliseconds: 500)),
//       transitionFn,
//     );
//   }

  bool _hasReachedMax(ListState state) =>
      state is ListSuccess && state.currentPage >= state.totalPages;
}
