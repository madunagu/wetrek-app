import 'package:flutter/foundation.dart';


@immutable
class Waypoint {

  const Waypoint({
    required this.geocoderStatus,
    required this.placeId,
    required this.types,
  });

  final String geocoderStatus;
  final String placeId;
  final List<String> types;

  factory Waypoint.fromJson(Map<String,dynamic> json) => Waypoint(
    geocoderStatus: json['geocoder_status'] as String,
    placeId: json['place_id'] as String,
    types: (json['types'] as List? ?? []).map((e) => e as String).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'geocoder_status': geocoderStatus,
    'place_id': placeId,
    'types': types.map((e) => e.toString()).toList()
  };

  Waypoint clone() => Waypoint(
    geocoderStatus: geocoderStatus,
    placeId: placeId,
    types: types.toList()
  );


  Waypoint copyWith({
    String? geocoderStatus,
    String? placeId,
    List<String>? types
  }) => Waypoint(
    geocoderStatus: geocoderStatus ?? this.geocoderStatus,
    placeId: placeId ?? this.placeId,
    types: types ?? this.types,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Waypoint && geocoderStatus == other.geocoderStatus && placeId == other.placeId && types == other.types;

  @override
  int get hashCode => geocoderStatus.hashCode ^ placeId.hashCode ^ types.hashCode;
}
