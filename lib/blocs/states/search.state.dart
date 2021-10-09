import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/pagination.dart';

enum SearchStatus { initial, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.models = const <Model>[],
    this.hasReachedMax = false,
    this.pagination = const Pagination(
      total: 20,
      count: 20,
      perPage: 20,
      currentPage: 1,
      totalPages: 100,
    ),
  });

  final SearchStatus status;
  final List<Model> models;
  final bool hasReachedMax;
  final Pagination pagination;

  SearchState copyWith({
    SearchStatus? status,
    List<Model>? models,
    Pagination? pagination,
    bool? hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      models: models ?? this.models,
      pagination: pagination ?? this.pagination,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${models.length} }''';
  }

  @override
  List<Object> get props => [status, models, hasReachedMax];
}
