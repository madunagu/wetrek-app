import 'package:flutter/foundation.dart';
import 'Detail.dart';
import 'Detail.dart';
import 'Location.dart';
import 'Location.dart';
import 'Step.dart';

@immutable
class Leg {

  const Leg({
    required this.distance,
    required this.duration,
    required this.endAddress,
    required this.endLocation,
    required this.startAddress,
    required this.startLocation,
    required this.steps,
    required this.trafficSpeedEntry,
    required this.viaWaypoint,
  });

  final Detail distance;
  final Detail duration;
  final String endAddress;
  final Location endLocation;
  final String startAddress;
  final Location startLocation;
  final List<Step> steps;
  final List<dynamic> trafficSpeedEntry;
  final List<dynamic> viaWaypoint;

  factory Leg.fromJson(Map<String,dynamic> json) => Leg(
    distance: json['distance'] as Detail,
    duration: json['duration'] as Detail,
    endAddress: json['end_address'] as String,
    endLocation: json['end_location'] as Location,
    startAddress: json['start_address'] as String,
    startLocation: json['start_location'] as Location,
    steps: (json['steps'] as List? ?? []).map((e) => e as Step).toList(),
    trafficSpeedEntry: (json['traffic_speed_entry'] as List? ?? []).map((e) => e as dynamic).toList(),
    viaWaypoint: (json['via_waypoint'] as List? ?? []).map((e) => e as dynamic).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'distance': distance,
    'duration': duration,
    'end_address': endAddress,
    'end_location': endLocation,
    'start_address': startAddress,
    'start_location': startLocation,
    'steps': steps.map((e) => e.toString()).toList(),
    'traffic_speed_entry': trafficSpeedEntry.map((e) => e.toString()).toList(),
    'via_waypoint': viaWaypoint.map((e) => e.toString()).toList()
  };

  Leg clone() => Leg(
    distance: distance,
    duration: duration,
    endAddress: endAddress,
    endLocation: endLocation,
    startAddress: startAddress,
    startLocation: startLocation,
    steps: steps.toList(),
    trafficSpeedEntry: trafficSpeedEntry.toList(),
    viaWaypoint: viaWaypoint.toList()
  );


  Leg copyWith({
    Detail? distance,
    Detail? duration,
    String? endAddress,
    Location? endLocation,
    String? startAddress,
    Location? startLocation,
    List<Step>? steps,
    List<dynamic>? trafficSpeedEntry,
    List<dynamic>? viaWaypoint
  }) => Leg(
    distance: distance ?? this.distance,
    duration: duration ?? this.duration,
    endAddress: endAddress ?? this.endAddress,
    endLocation: endLocation ?? this.endLocation,
    startAddress: startAddress ?? this.startAddress,
    startLocation: startLocation ?? this.startLocation,
    steps: steps ?? this.steps,
    trafficSpeedEntry: trafficSpeedEntry ?? this.trafficSpeedEntry,
    viaWaypoint: viaWaypoint ?? this.viaWaypoint,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Leg && distance == other.distance && duration == other.duration && endAddress == other.endAddress && endLocation == other.endLocation && startAddress == other.startAddress && startLocation == other.startLocation && steps == other.steps && trafficSpeedEntry == other.trafficSpeedEntry && viaWaypoint == other.viaWaypoint;

  @override
  int get hashCode => distance.hashCode ^ duration.hashCode ^ endAddress.hashCode ^ endLocation.hashCode ^ startAddress.hashCode ^ startLocation.hashCode ^ steps.hashCode ^ trafficSpeedEntry.hashCode ^ viaWaypoint.hashCode;
}
