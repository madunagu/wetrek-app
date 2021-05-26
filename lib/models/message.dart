import 'package:flutter/foundation.dart';
import 'User.dart';

@immutable
class Message {

  const Message({
    required this.message,
    required this.from,
    required this.createdAt,
    required this.modifiedAt,
  });

  final String message;
  final User from;
  final DateTime createdAt;
  final DateTime modifiedAt;

  factory Message.fromJson(Map<String,dynamic> json) => Message(
    message: json['message'] as String,
    from: json['from'] as User,
    createdAt: DateTime.parse(json['created_at'] as String),
    modifiedAt: DateTime.parse(json['modified_at'] as String)
  );
  
  Map<String, dynamic> toJson() => {
    'message': message,
    'from': from,
    'created_at': createdAt.toIso8601String(),
    'modified_at': modifiedAt.toIso8601String()
  };

  Message clone() => Message(
    message: message,
    from: from,
    createdAt: createdAt,
    modifiedAt: modifiedAt
  );


  Message copyWith({
    String? message,
    User? from,
    DateTime? createdAt,
    DateTime? modifiedAt
  }) => Message(
    message: message ?? this.message,
    from: from ?? this.from,
    createdAt: createdAt ?? this.createdAt,
    modifiedAt: modifiedAt ?? this.modifiedAt,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Message && message == other.message && from == other.from && createdAt == other.createdAt && modifiedAt == other.modifiedAt;

  @override
  int get hashCode => message.hashCode ^ from.hashCode ^ createdAt.hashCode ^ modifiedAt.hashCode;
}
