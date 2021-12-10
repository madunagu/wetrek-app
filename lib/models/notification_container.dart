import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';
import 'notification.dart';
import 'user.dart';

@immutable
class NotificationContainer extends Model {
  const NotificationContainer({
    required this.id,
    required this.type,
    required this.data,
    this.notifiable,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String type;
  final Notification data;
  final User? notifiable;
  final DateTime? readAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory NotificationContainer.fromJson(Map<String, dynamic> json) =>
      NotificationContainer(
          id: json['id'] as String,
          type: json['type'] as String,
          data: Notification.fromJson(json['data']),
          notifiable:
              json['notifiable'] != null ? json['notifiable'] as User : null,
          readAt:json['read_at'] !=null? DateTime.parse(json['read_at'] as String): null,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String));

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'data': data,
        'notifiable': notifiable,
        'read_at': readAt?.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String()
      };

  NotificationContainer clone() => NotificationContainer(
      id: id,
      type: type,
      data: data,
      notifiable: notifiable,
      readAt: readAt,
      createdAt: createdAt,
      updatedAt: updatedAt);

  NotificationContainer copyWith(
          {String? id,
          String? type,
          Notification? data,
          User? notifiable,
          DateTime? readAt,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      NotificationContainer(
        id: id ?? this.id,
        type: type ?? this.type,
        data: data ?? this.data,
        notifiable: notifiable ?? this.notifiable,
        readAt: readAt ?? this.readAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationContainer &&
          id == other.id &&
          type == other.type &&
          data == other.data &&
          notifiable == other.notifiable &&
          readAt == other.readAt &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      type.hashCode ^
      data.hashCode ^
      notifiable.hashCode ^
      readAt.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
