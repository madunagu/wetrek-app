import 'package:json_annotation/json_annotation.dart';
import 'Address.dart';
import 'Address.dart';
import 'User.dart';
import 'Location.dart';

part 'trek.g.dart';

@JsonSerializable()
class Trek {
      Trek();

  @JsonKey(name: 'start_address') Address startAddress;
  @JsonKey(name: 'end_address') Address endAddress;
  List<User> users;
  String name;
  List<Location> locations;
  @JsonKey(name: 'starting_at') DateTime startingAt;
  @JsonKey(name: 'ending_at') DateTime endingAt;
  @JsonKey(name: 'created_at') DateTime createdAt;

  factory Trek.fromJson(Map<String,dynamic> json) => _$TrekFromJson(json);
  Map<String, dynamic> toJson() => _$TrekToJson(this);
}
