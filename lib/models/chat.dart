import 'package:flutter/foundation.dart';
import 'Message.dart';

@immutable
class Chat {

  const Chat({
    required this.message,
    required this.count,
  });

  final Message message;
  final int count;

  factory Chat.fromJson(Map<String,dynamic> json) => Chat(
    message:Message.fromJson( json['message']),
    count: json['count'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'message': message,
    'count': count
  };

  Chat clone() => Chat(
    message: message,
    count: count
  );


  Chat copyWith({
    Message? message,
    int? count
  }) => Chat(
    message: message ?? this.message,
    count: count ?? this.count,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Chat && message == other.message && count == other.count;

  @override
  int get hashCode => message.hashCode ^ count.hashCode;
}
