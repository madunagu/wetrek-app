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
    required this.createdAt,
    required this.modifiedAt,
    this.messageCount,
    this.seenBy,
    this.seenAt,
  });

  final String message;
  final Messagable from;
  final DateTime createdAt;
  final DateTime modifiedAt;
  final int? messageCount;
  final List<int>? seenBy;
  final List<String>? seenAt;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
      from: json['messagable_type'] as String == 'trek'
          ? Trek.fromJson(json['messagable'])
          : User.fromJson(json['messagable']),
      messageCount: json['message_count'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      modifiedAt: DateTime.parse(json['modified_at'] as String),
      seenBy: json['seen_by'] != null
          ? (json['seen_by'] as List? ?? []).map((e) => e as int).toList()
          : null,
      seenAt: json['seen_at'] != null
          ? (json['seen_at'] as List? ?? []).map((e) => e as String).toList()
          : null);

  Map<String, dynamic> toJson() => {
        'message': message,
        'from': from,
        'message_count': messageCount,
        'created_at': createdAt.toIso8601String(),
        'modified_at': modifiedAt.toIso8601String(),
        'seen_by': seenBy?.map((e) => e.toString()).toList(),
        'seen_at': seenAt?.map((e) => e.toString()).toList()
      };

  Message clone() => Message(
      message: message,
      from: from,
      createdAt: createdAt,
      modifiedAt: modifiedAt,
      seenBy: seenBy?.toList(),
      seenAt: seenAt?.toList());

  Message copyWith(
          {String? message,
          Messagable? from,
          DateTime? createdAt,
          DateTime? modifiedAt,
          List<int>? seenBy,
          List<String>? seenAt}) =>
      Message(
        message: message ?? this.message,
        from: from ?? this.from,
        createdAt: createdAt ?? this.createdAt,
        modifiedAt: modifiedAt ?? this.modifiedAt,
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
          modifiedAt == other.modifiedAt &&
          seenBy == other.seenBy &&
          seenAt == other.seenAt;

  @override
  int get hashCode =>
      message.hashCode ^
      from.hashCode ^
      createdAt.hashCode ^
      modifiedAt.hashCode ^
      seenBy.hashCode ^
      seenAt.hashCode;
}
