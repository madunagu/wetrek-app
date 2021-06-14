import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';
import 'field.dart';
import 'geometry.dart';
import 'plus_code.dart';

@immutable
class Address extends Model {

  const Address({
    required this.addressComponents,
    required this.formattedAddress,
    required this.geometry,
    required this.placeId,
    required this.plusCode,
    required this.types,
  });

  final List<Field> addressComponents;
  final String formattedAddress;
  final Geometry geometry;
  final String placeId;
  final PlusCode plusCode;
  final List<String> types;

  factory Address.fromJson(Map<String,dynamic> json) => Address(
    addressComponents: (json['address_components'] as List? ?? []).map((e) => e as Field).toList(),
    formattedAddress: json['formatted_address'] as String,
    geometry: json['geometry'] as Geometry,
    placeId: json['place_id'] as String,
    plusCode: PlusCode.fromJson(json['plus_code'] as Map<String, dynamic>),
    types: (json['types'] as List? ?? []).map((e) => e as String).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'address_components': addressComponents.map((e) => e.toString()).toList(),
    'formatted_address': formattedAddress,
    'geometry': geometry,
    'place_id': placeId,
    'plus_code': plusCode.toJson(),
    'types': types.map((e) => e.toString()).toList()
  };

  Address clone() => Address(
    addressComponents: addressComponents.toList(),
    formattedAddress: formattedAddress,
    geometry: geometry,
    placeId: placeId,
    plusCode: plusCode.clone(),
    types: types.toList()
  );


  Address copyWith({
    List<Field>? addressComponents,
    String? formattedAddress,
    Geometry? geometry,
    String? placeId,
    PlusCode? plusCode,
    List<String>? types
  }) => Address(
    addressComponents: addressComponents ?? this.addressComponents,
    formattedAddress: formattedAddress ?? this.formattedAddress,
    geometry: geometry ?? this.geometry,
    placeId: placeId ?? this.placeId,
    plusCode: plusCode ?? this.plusCode,
    types: types ?? this.types,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Address && addressComponents == other.addressComponents && formattedAddress == other.formattedAddress && geometry == other.geometry && placeId == other.placeId && plusCode == other.plusCode && types == other.types;

  @override
  int get hashCode => addressComponents.hashCode ^ formattedAddress.hashCode ^ geometry.hashCode ^ placeId.hashCode ^ plusCode.hashCode ^ types.hashCode;
}
