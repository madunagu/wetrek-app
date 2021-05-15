// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleRoute _$GoogleRouteFromJson(Map<String, dynamic> json) {
  return GoogleRoute()
    ..bounds = json['bounds']
    ..copyrights = json['copyrights'] as String
    ..legs = json['legs'] as List
    ..overviewPolyline = json['overview_polyline']
    ..summary = json['summary'] as String
    ..warnings = json['warnings'] as List
    ..waypointOrder = json['waypoint_order'] as List;
}

Map<String, dynamic> _$GoogleRouteToJson(GoogleRoute instance) =>
    <String, dynamic>{
      'bounds': instance.bounds,
      'copyrights': instance.copyrights,
      'legs': instance.legs,
      'overview_polyline': instance.overviewPolyline,
      'summary': instance.summary,
      'warnings': instance.warnings,
      'waypoint_order': instance.waypointOrder,
    };
