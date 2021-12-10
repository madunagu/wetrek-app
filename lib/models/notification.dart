import 'package:flutter/foundation.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/models/messagable.dart';

@immutable
class Notification {

  const Notification({
    required this.objectType,
    required this.objectId,
    required this.body,
    this.notifyAt,
    required this.reccuring,
    required this.messagable,
    this.repeatAfter,
  });

  final String objectType;
  final int objectId;
  final String body;
  final DateTime? notifyAt;
  final bool reccuring;
  final Messagable messagable;
  final int? repeatAfter;

  factory Notification.fromJson(Map<String,dynamic> json) => Notification(
    objectType: json['object_type'] as String,
    objectId: json['object_id'] as int,
    body: json['body'] as String,
    notifyAt: json['notify_at'] != null ? DateTime.parse(json['notify_at'] as String) : null,
    reccuring: json['reccuring'] as bool,
    messagable:json['object_type'] as String == 'trek'
          ? Trek.fromJson(json['messagable'])
          : User.fromJson(json['messagable']),
    repeatAfter: json['repeat_after'] != null ? json['repeat_after'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'object_type': objectType,
    'object_id': objectId,
    'body': body,
    'notify_at': notifyAt?.toIso8601String(),
    'reccuring': reccuring,
    'messagable': messagable,
    'repeat_after': repeatAfter
  };

  Notification clone() => Notification(
    objectType: objectType,
    objectId: objectId,
    body: body,
    notifyAt: notifyAt,
    reccuring: reccuring,
    messagable: messagable,
    repeatAfter: repeatAfter
  );


  Notification copyWith({
    String? objectType,
    int? objectId,
    String? body,
    DateTime? notifyAt,
    bool? reccuring,
    Messagable? messagable,
    int? repeatAfter
  }) => Notification(
    objectType: objectType ?? this.objectType,
    objectId: objectId ?? this.objectId,
    body: body ?? this.body,
    notifyAt: notifyAt ?? this.notifyAt,
    reccuring: reccuring ?? this.reccuring,
    messagable: messagable ?? this.messagable,
    repeatAfter: repeatAfter ?? this.repeatAfter,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Notification && objectType == other.objectType && objectId == other.objectId && body == other.body && notifyAt == other.notifyAt && reccuring == other.reccuring && messagable == other.messagable && repeatAfter == other.repeatAfter;

  @override
  int get hashCode => objectType.hashCode ^ objectId.hashCode ^ body.hashCode ^ notifyAt.hashCode ^ reccuring.hashCode ^ messagable.hashCode ^ repeatAfter.hashCode;
}
