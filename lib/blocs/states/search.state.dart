import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';

enum SearchStatus { initial, success, failure }

class SearchState extends Equatable {
  const SearchState({
    this.status = SearchStatus.initial,
    this.models = const <Model>[],
    this.hasReachedMax = false,
  });

  final SearchStatus status;
  final List<Model> models;
  final bool hasReachedMax;

  SearchState copyWith({
    SearchStatus? status,
    List<Model>? models,
    bool? hasReachedMax,
  }) {
    return SearchState(
      status: status ?? this.status,
      models: models ?? this.models,
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
