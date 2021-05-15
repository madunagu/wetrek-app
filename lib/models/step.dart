import 'package:json_annotation/json_annotation.dart';
import 'Detail.dart';
import 'Detail.dart';
import 'Location.dart';
import 'Polyline.dart';
import 'Location.dart';

part 'step.g.dart';

@JsonSerializable()
class Step {
      Step();

  Detail distance;
  Detail duration;
  @JsonKey(name: 'end_location') Location endLocation;
  @JsonKey(name: 'html_instructions') String htmlInstructions;
  Polyline polyline;
  @JsonKey(name: 'start_location') Location startLocation;
  @JsonKey(name: 'travel_mode') String travelMode;

  factory Step.fromJson(Map<String,dynamic> json) => _$StepFromJson(json);
  Map<String, dynamic> toJson() => _$StepToJson(this);
}
