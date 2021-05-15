import 'package:json_annotation/json_annotation.dart';
import 'Detail.dart';
import 'Detail.dart';
import 'Location.dart';
import 'Location.dart';
import 'Step.dart';

part 'leg.g.dart';

@JsonSerializable()
class Leg {
      Leg();

  Detail distance;
  Detail duration;
  @JsonKey(name: 'end_address') String endAddress;
  @JsonKey(name: 'end_location') Location endLocation;
  @JsonKey(name: 'start_address') String startAddress;
  @JsonKey(name: 'start_location') Location startLocation;
  List<Step> steps;
  @JsonKey(name: 'traffic_speed_entry') List<dynamic> trafficSpeedEntry;
  @JsonKey(name: 'via_waypoint') List<dynamic> viaWaypoint;

  factory Leg.fromJson(Map<String,dynamic> json) => _$LegFromJson(json);
  Map<String, dynamic> toJson() => _$LegToJson(this);
}
