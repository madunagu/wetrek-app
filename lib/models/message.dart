import 'package:flutter/foundation.dart';
import 'package:wetrek/models/messagable.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/user.dart';

@immutable
class Message extends Model {
  const Message({
    required this.message,
    required this.from,
    required this.to,
    required this.createdAt,
    required this.updatedAt,
    this.messageCount,
    this.seenBy,
    this.seenAt,
  });

  final String message;
  final Messagable from;
  final Messagable to;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? messageCount;
  final List<int>? seenBy;
  final List<String>? seenAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
      from: json['messagable_type'] as String == 'trek'
          ? Trek.fromJson(json['messagable'])
          : User.fromJson(json['messagable']),
      to: User.fromJson(json['sender']),
      messageCount: json['message_count'] != null
          ? int.parse(json['message_count'] as String)
          : 0,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      seenBy: json['seen_by'] != null
          ? (json['seen_by'] as List? ?? []).map((e) => e as int).toList()
          : null,
      seenAt: json['seen_at'] != null
          ? (json['seen_at'] as List? ?? []).map((e) => e as String).toList()
          : null);

  Map<String, dynamic> toJson() => {
        'message': message,
        'from': from,
        'to': to,
        'message_count': messageCount,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
        'seen_by': seenBy?.map((e) => e.toString()).toList(),
        'seen_at': seenAt?.map((e) => e.toString()).toList()
      };

  Message clone() => Message(
      message: message,
      from: from,
      to: to,
      createdAt: createdAt,
      updatedAt: updatedAt,
      seenBy: seenBy?.toList(),
      seenAt: seenAt?.toList());

  Message copyWith(
          {String? message,
          Messagable? from,
          Messagable? to,
          DateTime? createdAt,
          DateTime? updatedAt,
          List<int>? seenBy,
          List<String>? seenAt}) =>
      Message(
        message: message ?? this.message,
        from: from ?? this.from,
        to: from ?? this.to,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        seenBy: seenBy ?? this.seenBy,
        seenAt: seenAt ?? this.seenAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          message == other.message &&
          from == other.from &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          seenBy == other.seenBy &&
          seenAt == other.seenAt;

  @override
  int get hashCode =>
      message.hashCode ^
      from.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      seenBy.hashCode ^
      seenAt.hashCode;
}
