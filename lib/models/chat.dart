import 'package:json_annotation/json_annotation.dart';
import 'Message.dart';
import 'User.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
      Chat();

  Message message;
  int count;
  User from;
  @JsonKey(name: 'created_at') DateTime createdAt;

  factory Chat.fromJson(Map<String,dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
