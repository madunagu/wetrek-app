import 'package:flutter/foundation.dart';
import 'bounds.dart';
import 'leg.dart';
import 'polyline.dart';

@immutable
class Track {

  const Track({
    required this.bounds,
    required this.copyrights,
    required this.legs,
    required this.overviewPolyline,
    required this.summary,
    required this.warnings,
    required this.waypointOrder,
  });

  final Bounds bounds;
  final String copyrights;
  final List<Leg> legs;
  final Polyline overviewPolyline;
  final String summary;
  final List<dynamic> warnings;
  final List<int> waypointOrder;

  factory Track.fromJson(Map<String,dynamic> json) => Track(
    bounds:Bounds.fromJson(json['bounds']),
    copyrights: json['copyrights'] as String,
    legs: (json['legs'] as List? ?? []).map((e) => Leg.fromJson(e)).toList(),
    overviewPolyline: Polyline.fromJson(json['overview_polyline']),
    summary: json['summary'] as String,
    warnings: (json['warnings'] as List? ?? []).map((e) => e as dynamic).toList(),
    waypointOrder: (json['waypoint_order'] as List? ?? []).map((e) => e as int).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'bounds': bounds.toJson(),
    'copyrights': copyrights,
    'legs': legs.map((e) => e.toJson()).toList(),
    'overview_polyline': overviewPolyline.toJson(),
    'summary': summary,
    'warnings': warnings.map((e) => e.toJson()).toList(),
    'waypoint_order': waypointOrder.map((e) => e.toString()).toList()
  };

  Track clone() => Track(
    bounds: bounds,
    copyrights: copyrights,
    legs: legs.toList(),
    overviewPolyline: overviewPolyline,
    summary: summary,
    warnings: warnings.toList(),
    waypointOrder: waypointOrder.toList()
  );


  Track copyWith({
    Bounds? bounds,
    String? copyrights,
    List<Leg>? legs,
    Polyline? overviewPolyline,
    String? summary,
    List<dynamic>? warnings,
    List<int>? waypointOrder
  }) => Track(
    bounds: bounds ?? this.bounds,
    copyrights: copyrights ?? this.copyrights,
    legs: legs ?? this.legs,
    overviewPolyline: overviewPolyline ?? this.overviewPolyline,
    summary: summary ?? this.summary,
    warnings: warnings ?? this.warnings,
    waypointOrder: waypointOrder ?? this.waypointOrder,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Track && bounds == other.bounds && copyrights == other.copyrights && legs == other.legs && overviewPolyline == other.overviewPolyline && summary == other.summary && warnings == other.warnings && waypointOrder == other.waypointOrder;

  @override
  int get hashCode => bounds.hashCode ^ copyrights.hashCode ^ legs.hashCode ^ overviewPolyline.hashCode ^ summary.hashCode ^ warnings.hashCode ^ waypointOrder.hashCode;
}
