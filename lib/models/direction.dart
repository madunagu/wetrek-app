import 'package:flutter/foundation.dart';
import 'waypoint.dart';
import 'track.dart';

@immutable
class Direction {

  const Direction({
    required this.geocodedWaypoints,
    required this.routes,
    required this.status,
  });

  final List<Waypoint> geocodedWaypoints;
  final List<Track> routes;
  final String status;

  factory Direction.fromJson(Map<String,dynamic> json) => Direction(
    geocodedWaypoints: (json['geocoded_waypoints'] as List? ?? []).map((e) => Waypoint.fromJson(e)).toList(),
    routes: (json['routes'] as List? ?? []).map((e) => Track.fromJson(e)).toList(),
    status: json['status'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'geocoded_waypoints': geocodedWaypoints.map((e) => e.toString()).toList(),
    'routes': routes.map((e) => e.toString()).toList(),
    'status': status
  };

  Direction clone() => Direction(
    geocodedWaypoints: geocodedWaypoints.toList(),
    routes: routes.toList(),
    status: status
  );


  Direction copyWith({
    List<Waypoint>? geocodedWaypoints,
    List<Track>? routes,
    String? status
  }) => Direction(
    geocodedWaypoints: geocodedWaypoints ?? this.geocodedWaypoints,
    routes: routes ?? this.routes,
    status: status ?? this.status,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Direction && geocodedWaypoints == other.geocodedWaypoints && routes == other.routes && status == other.status;

  @override
  int get hashCode => geocodedWaypoints.hashCode ^ routes.hashCode ^ status.hashCode;
}
