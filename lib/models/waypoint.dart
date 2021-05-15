import 'package:json_annotation/json_annotation.dart';


part 'waypoint.g.dart';

@JsonSerializable()
class Waypoint {
      Waypoint();

  @JsonKey(name: 'geocoder_status') String geocoderStatus;
  @JsonKey(name: 'place_id') String placeId;
  List<dynamic> types;

  factory Waypoint.fromJson(Map<String,dynamic> json) => _$WaypointFromJson(json);
  Map<String, dynamic> toJson() => _$WaypointToJson(this);
}
