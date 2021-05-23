// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trek.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trek _$TrekFromJson(Map<String, dynamic> json) {
  return Trek()
    ..startAddress = json['start_address']
    ..endAddress = json['end_address']
    ..users = json['users'] as List
    ..name = json['name'] as String
    ..locations = json['locations'] as List
    ..startingAt = json['starting_at'] == null
        ? null
        : DateTime.parse(json['starting_at'] as String)
    ..endingAt = json['ending_at'] == null
        ? null
        : DateTime.parse(json['ending_at'] as String)
    ..createdAt = json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String);
}

Map<String, dynamic> _$TrekToJson(Trek instance) => <String, dynamic>{
      'start_address': instance.startAddress,
      'end_address': instance.endAddress,
      'users': instance.users,
      'name': instance.name,
      'locations': instance.locations,
      'starting_at': instance.startingAt?.toIso8601String(),
      'ending_at': instance.endingAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
    };
