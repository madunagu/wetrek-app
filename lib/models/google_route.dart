import 'package:json_annotation/json_annotation.dart';
import 'Bounds.dart';
import 'Leg.dart';
import 'Polyline.dart';

part 'google_route.g.dart';

@JsonSerializable()
class GoogleRoute {
      GoogleRoute();

  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  @JsonKey(name: 'overview_polyline') Polyline overviewPolyline;
  String summary;
  List<dynamic> warnings;
  @JsonKey(name: 'waypoint_order') List<dynamic> waypointOrder;

  factory GoogleRoute.fromJson(Map<String,dynamic> json) => _$GoogleRouteFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleRouteToJson(this);
}
