import 'package:equatable/equatable.dart';
import 'package:wetrek/models/model.dart';

enum ChatStatus { initial, success, failure }

class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.models = const <Model>[],
    this.hasReachedMax = false,
  });

  final ChatStatus status;
  final List<Model> models;
  final bool hasReachedMax;

  ChatState copyWith({
    ChatStatus? status,
    List<Model>? models,
    bool? hasReachedMax,
  }) {
    return ChatState(
      status: status ?? this.status,
      models: models ?? this.models,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ChatState { status: $status, hasReachedMax: $hasReachedMax, posts: ${models.length} }''';
  }

  @override
  List<Object> get props => [status, models, hasReachedMax];
}
