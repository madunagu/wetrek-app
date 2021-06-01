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
    required this.startLocation,
    required this.travelMode,
  });

  final Detail distance;
  final Detail duration;
  final Location endLocation;
  final String htmlInstructions;
  final Polyline polyline;
  final Location startLocation;
  final String travelMode;

  factory Step.fromJson(Map<String,dynamic> json) => Step(
    distance: json['distance'] as Detail,
    duration: json['duration'] as Detail,
    endLocation: json['end_location'] as Location,
    htmlInstructions: json['html_instructions'] as String,
    polyline: json['polyline'] as Polyline,
    startLocation: json['start_location'] as Location,
    travelMode: json['travel_mode'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'distance': distance,
    'duration': duration,
    'end_location': endLocation,
    'html_instructions': htmlInstructions,
    'polyline': polyline,
    'start_location': startLocation,
    'travel_mode': travelMode
  };

  Step clone() => Step(
    distance: distance,
    duration: duration,
    endLocation: endLocation,
    htmlInstructions: htmlInstructions,
    polyline: polyline,
    startLocation: startLocation,
    travelMode: travelMode
  );


  Step copyWith({
    Detail? distance,
    Detail? duration,
    Location? endLocation,
    String? htmlInstructions,
    Polyline? polyline,
    Location? startLocation,
    String? travelMode
  }) => Step(
    distance: distance ?? this.distance,
    duration: duration ?? this.duration,
    endLocation: endLocation ?? this.endLocation,
    htmlInstructions: htmlInstructions ?? this.htmlInstructions,
    polyline: polyline ?? this.polyline,
    startLocation: startLocation ?? this.startLocation,
    travelMode: travelMode ?? this.travelMode,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Step && distance == other.distance && duration == other.duration && endLocation == other.endLocation && htmlInstructions == other.htmlInstructions && polyline == other.polyline && startLocation == other.startLocation && travelMode == other.travelMode;

  @override
  int get hashCode => distance.hashCode ^ duration.hashCode ^ endLocation.hashCode ^ htmlInstructions.hashCode ^ polyline.hashCode ^ startLocation.hashCode ^ travelMode.hashCode;
}
