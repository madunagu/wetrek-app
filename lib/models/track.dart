import 'package:json_annotation/json_annotation.dart';
import 'Bounds.dart';
import 'Leg.dart';
import 'Polyline.dart';

part 'track.g.dart';

@JsonSerializable()
class Track {
      Track();

  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  @JsonKey(name: 'overview_polyline') Polyline overviewPolyline;
  String summary;
  List<dynamic> warnings;
  @JsonKey(name: 'waypoint_order') List<dynamic> waypointOrder;

  factory Track.fromJson(Map<String,dynamic> json) => _$TrackFromJson(json);
  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
