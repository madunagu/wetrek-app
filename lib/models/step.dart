import 'package:flutter/foundation.dart';
import 'detail.dart';
import 'location.dart';
import 'polyline.dart';

@immutable
class Step {
  const Step({
    required this.distance,
    required this.duration,
    required this.endLocation,
    required this.htmlInstructions,
    required this.polyline,
    this.maneuver,
    required this.startLocation,
    required this.travelMode,
  });

  final Detail distance;
  final Detail duration;
  final Location endLocation;
  final String htmlInstructions;
  final Polyline polyline;
  final String? maneuver;
  final Location startLocation;
  final String travelMode;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
      distance: Detail.fromJson(json['distance']),
      duration: Detail.fromJson(json['duration']),
      endLocation: Location.fromJson(json['end_location']),
      htmlInstructions: json['html_instructions'] as String,
      polyline: Polyline.fromJson(json['polyline']),
      maneuver: json['maneuver'] != null ? json['maneuver'] as String : null,
      startLocation: Location.fromJson(json['start_location']),
      travelMode: json['travel_mode'] as String);

  Map<String, dynamic> toJson() => {
        'distance': distance,
        'duration': duration,
        'end_location': endLocation,
        'html_instructions': htmlInstructions,
        'polyline': polyline,
        'maneuver': maneuver,
        'start_location': startLocation,
        'travel_mode': travelMode
      };

  Step clone() => Step(
      distance: distance,
      duration: duration,
      endLocation: endLocation,
      htmlInstructions: htmlInstructions,
      polyline: polyline,
      maneuver: maneuver,
      startLocation: startLocation,
      travelMode: travelMode);

  Step copyWith(
          {Detail? distance,
          Detail? duration,
          Location? endLocation,
          String? htmlInstructions,
          Polyline? polyline,
          String? maneuver,
          Location? startLocation,
          String? travelMode}) =>
      Step(
        distance: distance ?? this.distance,
        duration: duration ?? this.duration,
        endLocation: endLocation ?? this.endLocation,
        htmlInstructions: htmlInstructions ?? this.htmlInstructions,
        polyline: polyline ?? this.polyline,
        maneuver: maneuver ?? this.maneuver,
        startLocation: startLocation ?? this.startLocation,
        travelMode: travelMode ?? this.travelMode,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Step &&
          distance == other.distance &&
          duration == other.duration &&
          endLocation == other.endLocation &&
          htmlInstructions == other.htmlInstructions &&
          polyline == other.polyline &&
          maneuver == other.maneuver &&
          startLocation == other.startLocation &&
          travelMode == other.travelMode;

  @override
  int get hashCode =>
      distance.hashCode ^
      duration.hashCode ^
      endLocation.hashCode ^
      htmlInstructions.hashCode ^
      polyline.hashCode ^
      maneuver.hashCode ^
      startLocation.hashCode ^
      travelMode.hashCode;
}
