// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'waypoint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Waypoint _$WaypointFromJson(Map<String, dynamic> json) {
  return Waypoint()
    ..geocoderStatus = json['geocoder_status'] as String
    ..placeId = json['place_id'] as String
    ..types = json['types'] as List;
}

Map<String, dynamic> _$WaypointToJson(Waypoint instance) => <String, dynamic>{
      'geocoder_status': instance.geocoderStatus,
      'place_id': instance.placeId,
      'types': instance.types,
    };
