// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address()
    ..addressComponents = json['address_components'] as List
    ..formattedAddress = json['formatted_address'] as String
    ..geometry = json['geometry'] == null
        ? null
        : Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
    ..placeId = json['place_id'] as String
    ..plusCode = json['plus_code'] == null
        ? null
        : PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>)
    ..types = json['types'] as List;
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'address_components': instance.addressComponents,
      'formatted_address': instance.formattedAddress,
      'geometry': instance.geometry,
      'place_id': instance.placeId,
      'plus_code': instance.plusCode,
      'types': instance.types,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) {
  return Geometry()
    ..location = json['location'] == null
        ? null
        : Location.fromJson(json['location'] as Map<String, dynamic>)
    ..locationType = json['location_type'] as String
    ..viewport = json['viewport'] == null
        ? null
        : Viewport.fromJson(json['viewport'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'location_type': instance.locationType,
      'viewport': instance.viewport,
    };

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location()
    ..lat = (json['lat'] as num)?.toDouble()
    ..lng = (json['lng'] as num)?.toDouble();
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) {
  return Viewport()
    ..northeast = json['northeast'] == null
        ? null
        : Northeast.fromJson(json['northeast'] as Map<String, dynamic>)
    ..southwest = json['southwest'] == null
        ? null
        : Southwest.fromJson(json['southwest'] as Map<String, dynamic>);
}

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };

Northeast _$NortheastFromJson(Map<String, dynamic> json) {
  return Northeast()
    ..lat = (json['lat'] as num)?.toDouble()
    ..lng = (json['lng'] as num)?.toDouble();
}

Map<String, dynamic> _$NortheastToJson(Northeast instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Southwest _$SouthwestFromJson(Map<String, dynamic> json) {
  return Southwest()
    ..lat = (json['lat'] as num)?.toDouble()
    ..lng = (json['lng'] as num)?.toDouble();
}

Map<String, dynamic> _$SouthwestToJson(Southwest instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

PlusCode _$PlusCodeFromJson(Map<String, dynamic> json) {
  return PlusCode()
    ..compoundCode = json['compound_code'] as String
    ..globalCode = json['global_code'] as String;
}

Map<String, dynamic> _$PlusCodeToJson(PlusCode instance) => <String, dynamic>{
      'compound_code': instance.compoundCode,
      'global_code': instance.globalCode,
    };
