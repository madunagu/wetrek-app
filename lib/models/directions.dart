import 'package:json_annotation/json_annotation.dart';
import 'Waypoint.dart';
import 'Track.dart';

part 'directions.g.dart';

@JsonSerializable()
class Directions {
      Directions();

  @JsonKey(name: 'geocoded_waypoints') List<Waypoint> geocodedWaypoints;
  List<Track> routes;
  String status;

  factory Directions.fromJson(Map<String,dynamic> json) => _$DirectionsFromJson(json);
  Map<String, dynamic> toJson() => _$DirectionsToJson(this);
}
