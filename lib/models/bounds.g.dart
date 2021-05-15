// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bounds.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Bounds _$BoundsFromJson(Map<String, dynamic> json) {
  return Bounds()
    ..northeast = json['northeast']
    ..southwest = json['southwest'];
}

Map<String, dynamic> _$BoundsToJson(Bounds instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };
