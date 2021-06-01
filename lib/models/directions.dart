import 'package:flutter/foundation.dart';
import 'waypoint.dart';
import 'track.dart';

@immutable
class Directions {

  const Directions({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });

  final List<Waypoint> geocodedWaypoints;
  final List<Track> routes;
  final String status;

  factory Directions.fromJson(Map<String,dynamic> json) => Directions(
    geocodedWaypoints: (json['geocoded_waypoints'] as List? ?? []).map((e) => e as Waypoint).toList(),
    routes: (json['routes'] as List? ?? []).map((e) => e as Track).toList(),
    status: json['status'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'geocoded_waypoints': geocodedWaypoints.map((e) => e.toString()).toList(),
    'routes': routes.map((e) => e.toString()).toList(),
    'status': status
  };

  Directions clone() => Directions(
    geocodedWaypoints: geocodedWaypoints.toList(),
    routes: routes.toList(),
    status: status
  );


  Directions copyWith({
    List<Waypoint>? geocodedWaypoints,
    List<Track>? routes,
    String? status
  }) => Directions(
    geocodedWaypoints: geocodedWaypoints ?? this.geocodedWaypoints,
    routes: routes ?? this.routes,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Directions && geocodedWaypoints == other.geocodedWaypoints && routes == other.routes && status == other.status;

  @override
  int get hashCode => geocodedWaypoints.hashCode ^ routes.hashCode ^ status.hashCode;
}
