import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


@immutable
class Location {

  const Location({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory Location.fromJson(Map<String,dynamic> json) => Location(
    lat: json['lat'] as double,
    lng: json['lng'] as double
  );
  
  Map<String, dynamic> toJson() => {
    'lat': lat,
    'lng': lng
  };


  toLatLng() => LatLng(lat, lng);

  Location clone() => Location(
    lat: lat,
    lng: lng
  );

  LatLng transform(){
    return LatLng(lat, lng);
  }


  Location copyWith({
    double? lat,
    double? lng
  }) => Location(
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Location && lat == other.lat && lng == other.lng;

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;
}
