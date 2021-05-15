import 'package:json_annotation/json_annotation.dart';


part 'detail.g.dart';

@JsonSerializable()
class Detail {
      Detail();

  double value;
  String text;

  factory Detail.fromJson(Map<String,dynamic> json) => _$DetailFromJson(json);
  Map<String, dynamic> toJson() => _$DetailToJson(this);
}
