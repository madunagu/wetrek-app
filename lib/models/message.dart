import 'package:json_annotation/json_annotation.dart';
import 'User.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
      Message();

  String message;
  User from;
  @JsonKey(name: 'created_at') DateTime createdAt;
  @JsonKey(name: 'modified_at') DateTime modifiedAt;

  factory Message.fromJson(Map<String,dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
