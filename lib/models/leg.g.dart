// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leg _$LegFromJson(Map<String, dynamic> json) {
  return Leg()
    ..distance = json['distance']
    ..duration = json['duration']
    ..endAddress = json['end_address'] as String
    ..endLocation = json['end_location']
    ..startAddress = json['start_address'] as String
    ..startLocation = json['start_location']
    ..steps = json['steps'] as List
    ..trafficSpeedEntry = json['traffic_speed_entry'] as List
    ..viaWaypoint = json['via_waypoint'] as List;
}

Map<String, dynamic> _$LegToJson(Leg instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_address': instance.endAddress,
      'end_location': instance.endLocation,
      'start_address': instance.startAddress,
      'start_location': instance.startLocation,
      'steps': instance.steps,
      'traffic_speed_entry': instance.trafficSpeedEntry,
      'via_waypoint': instance.viaWaypoint,
    };
