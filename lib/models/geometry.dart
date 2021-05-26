import 'package:flutter/foundation.dart';
import 'Location.dart';
import 'Bounds.dart';

@immutable
class Geometry {

  const Geometry({
    required this.location,
    required this.locationType,
    required this.viewport,
  });

  final Location location;
  final String locationType;
  final Bounds viewport;

  factory Geometry.fromJson(Map<String,dynamic> json) => Geometry(
    location: json['location'] as Location,
    locationType: json['location_type'] as String,
    viewport: json['viewport'] as Bounds
  );
  
  Map<String, dynamic> toJson() => {
    'location': location,
    'location_type': locationType,
    'viewport': viewport
  };

  Geometry clone() => Geometry(
    location: location,
    locationType: locationType,
    viewport: viewport
  );


  Geometry copyWith({
    Location? location,
    String? locationType,
    Bounds? viewport
  }) => Geometry(
    location: location ?? this.location,
    locationType: locationType ?? this.locationType,
    viewport: viewport ?? this.viewport,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Geometry && location == other.location && locationType == other.locationType && viewport == other.viewport;

  @override
  int get hashCode => location.hashCode ^ locationType.hashCode ^ viewport.hashCode;
}
