import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/pagination.dart';

enum ChatStatus { initial, success, failure }

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
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

  final ChatStatus status;
  final List<Model> models;
  final bool hasReachedMax;
  final Pagination pagination;

  ChatState copyWith({
    ChatStatus? status,
    List<Model>? models,
    bool? hasReachedMax,
    Pagination? pagination
  }) {
    return ChatState(
      status: status ?? this.status,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  String toString() {
    return '''ChatState { status: $status, hasReachedMax: $hasReachedMax, posts: ${models.length} }''';
  }

  @override
  List<Object> get props => [status, models, hasReachedMax];
}
