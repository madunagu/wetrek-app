// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat()
    ..message = json['message']
    ..count = json['count'] as int
    ..from = json['from']
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String);
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'message': instance.message,
      'count': instance.count,
      'from': instance.from,
      'created_at': instance.createdAt?.toIso8601String(),
    };
