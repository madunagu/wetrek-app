import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';

abstract class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

class ListInitial extends ListState {}

class ListFailure extends ListState {}

class ListProgress extends ListState {}

class ListSuccess extends ListState {
  final List<Model> models;
  final int currentPage;
  final int totalPages;

  const ListSuccess({
    required this.models,
    required this.currentPage,
    required this.totalPages,
  });

  ListSuccess copyWith({
    List<Model>? models,
    int? totalPages,
    int? currentPage,
  }) {
    return ListSuccess(
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
