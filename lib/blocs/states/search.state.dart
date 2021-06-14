import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchFailure extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Model> models;
  final int currentPage;
  final int totalPages;

  const SearchSuccess({
    required this.models,
    required this.currentPage,
    required this.totalPages,
  });

  SearchSuccess copyWith({
    List<Model>? models,
    int? totalPages,
    int? currentPage,
  }) {
    return SearchSuccess(
      models: models ?? this.models,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object> get props => [
        models,
        currentPage,
        totalPages,
      ];

  @override
  String toString() =>
      'ListSuccess { Lists: ${models.length}, total Pages: $totalPages ,Current Pages $currentPage }';
}
