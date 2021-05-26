import 'package:flutter/foundation.dart';
import 'Message.dart';
import 'User.dart';

@immutable
class Chat {

  const Chat({
    required this.message,
    required this.count,
    required this.from,
    required this.createdAt,
  });

  final Message message;
  final int count;
  final User from;
  final DateTime createdAt;

  factory Chat.fromJson(Map<String,dynamic> json) => Chat(
    message: json['message'] as Message,
    count: json['count'] as int,
    from: json['from'] as User,
    createdAt: DateTime.parse(json['created_at'] as String)
  );
  
  Map<String, dynamic> toJson() => {
    'message': message,
    'count': count,
    'from': from,
    'created_at': createdAt.toIso8601String()
  };

  Chat clone() => Chat(
    message: message,
    count: count,
    from: from,
    createdAt: createdAt
  );


  Chat copyWith({
    Message? message,
    int? count,
    User? from,
    DateTime? createdAt
  }) => Chat(
    message: message ?? this.message,
    count: count ?? this.count,
    from: from ?? this.from,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Chat && message == other.message && count == other.count && from == other.from && createdAt == other.createdAt;

  @override
  int get hashCode => message.hashCode ^ count.hashCode ^ from.hashCode ^ createdAt.hashCode;
}
