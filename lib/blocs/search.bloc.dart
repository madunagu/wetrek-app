import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({
    required this.repository,
  }) : super(const SearchState());
  final Repository repository;

  //TODO: work on navigation in infinite list
  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    log('searching from bloc');
    if (event is SearchFetched) {
      yield* _mapPostFetchedToState(event, state);
    }
  }

  Stream<SearchState> _mapPostFetchedToState(
      SearchFetched event, SearchState state) async* {
    bool searchChanged = state.query != event.query;
    log('searching from searchfetched');
    if (!searchChanged && state.hasReachedMax) {
      log('maximum number of elements reached');
      yield state;
    } else if (searchChanged) {
      yield state.copyWith(status: SearchStatus.initial, models: []);

      try {
        final Paginated<Model> paginatedList = await repository.list(
          Parameters(
            page: 1,
            length: 20,
            q: event.query ?? '',
            conditions: event.conditions ?? [],
          ),
        );
        yield state.copyWith(
          status: SearchStatus.success,
          models: List.of(paginatedList.data),
          hasReachedMax: paginatedList.pagination.isLastPage(),
          pagination: paginatedList.pagination,
        );
      } on Exception {
        yield state.copyWith(status: SearchStatus.failure);
      }
    } else {
      // yield state.copyWith(status: SearchStatus.initial, models: []);

      try {
        final Paginated<Model> paginatedList = await repository.list(
          Parameters(
            page: state.pagination.currentPage + 1,
            length: 20,
            q: event.query ?? '',
            conditions: event.conditions ?? [],
          ),
        );
        yield state.copyWith(
          status: SearchStatus.success,
          models: List.of(state.models)..addAll(paginatedList.data),
          hasReachedMax: paginatedList.pagination.isLastPage(),
          pagination: paginatedList.pagination,
        );
      } on Exception {
        yield state.copyWith(status: SearchStatus.failure);
      }
    }
  }

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
    Stream<SearchEvent> events,
    TransitionFunction<SearchEvent, SearchState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
