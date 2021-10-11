import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location.dart';

@immutable
class Bounds {
  const Bounds({
    required this.northeast,
    required this.southwest,
  });

  final Location northeast;
  final Location southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
        northeast: Location.fromJson(json['northeast']),
        southwest: Location.fromJson(json['southwest']),
      );

  Map<String, dynamic> toJson() =>
      {'northeast': northeast.toJson(), 'southwest': southwest.toJson()};

  Bounds clone() => Bounds(northeast: northeast, southwest: southwest);

  Bounds copyWith({Location? northeast, Location? southwest}) => Bounds(
        northeast: northeast ?? this.northeast,
        southwest: southwest ?? this.southwest,
      );

  LatLngBounds toLatLng() {
    return LatLngBounds(
      southwest: LatLng(southwest.lat, southwest.lng),
      northeast: LatLng(northeast.lat, northeast.lng),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Bounds &&
          northeast == other.northeast &&
          southwest == other.southwest;

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;
}
