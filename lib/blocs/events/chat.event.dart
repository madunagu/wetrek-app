import 'package:equatable/equatable.dart';
import 'package:wetrek/models/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object> get props => [];
}

class ChatFetched extends ChatEvent {
  const ChatFetched({this.query});
  final String? query;
  @override
  List<Object> get props => [query ?? ''];
}

class ChatAdded extends ChatEvent {
  const ChatAdded({required this.message});
  final Message message;
  @override
  List<Object> get props => [message];
}
