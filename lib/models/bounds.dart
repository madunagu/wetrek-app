import 'package:json_annotation/json_annotation.dart';
import 'Location.dart';
import 'Location.dart';

part 'bounds.g.dart';

@JsonSerializable()
class Bounds {
      Bounds();

  Location northeast;
  Location southwest;

  factory Bounds.fromJson(Map<String,dynamic> json) => _$BoundsFromJson(json);
  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}
