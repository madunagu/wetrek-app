// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'directions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Directions _$DirectionsFromJson(Map<String, dynamic> json) {
  return Directions()
    ..geocodedWaypoints = json['geocoded_waypoints'] as List
    ..routes = json['routes'] as List
    ..status = json['status'] as String;
}

Map<String, dynamic> _$DirectionsToJson(Directions instance) =>
    <String, dynamic>{
      'geocoded_waypoints': instance.geocodedWaypoints,
      'routes': instance.routes,
      'status': instance.status,
    };
