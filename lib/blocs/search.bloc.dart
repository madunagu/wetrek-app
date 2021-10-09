import 'dart:async';
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
    if (event is SearchFetched) {
      yield await _mapPostFetchedToState(event, state);
    }
  }

  Future<SearchState> _mapPostFetchedToState(
      SearchFetched event, SearchState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == SearchStatus.initial) {
        final Paginated<Model> paginatedList = await repository.list(
          Parameters(
            page: 0,
            length: 20,
            q: event.query ?? '',
          ),
        );

        return state.copyWith(
          status: SearchStatus.success,
          models: paginatedList.data,
          hasReachedMax: paginatedList.pagination.isLastPage(),
        );
      }
      final Paginated<Model> paginatedList = await repository.list(
        Parameters(
          page: state.pagination.currentPage + 1,
          length: 20,
          q: event.query ?? '',
        ),
      );
      return state.copyWith(
        status: SearchStatus.success,
        models: event.query != null
            ? List.of(paginatedList.data)
            : List.of(state.models)
          ..addAll(paginatedList.data),
        hasReachedMax: paginatedList.pagination.isLastPage(),
      );
    } on Exception {
      return state.copyWith(status: SearchStatus.failure);
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
