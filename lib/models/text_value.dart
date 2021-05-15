import 'package:json_annotation/json_annotation.dart';


part 'text_value.g.dart';

@JsonSerializable()
class TextValue {
      TextValue();

  double value;
  String text;

  factory TextValue.fromJson(Map<String,dynamic> json) => _$TextValueFromJson(json);
  Map<String, dynamic> toJson() => _$TextValueToJson(this);
}
