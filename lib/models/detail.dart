import 'package:flutter/foundation.dart';

@immutable
class Detail {
  const Detail({
    required this.value,
    required this.text,
  });

  final double value;
  final String text;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
      value: (json['value'] as int)/1,
      text: json['text'] as String);

  Map<String, dynamic> toJson() => {'value': value, 'text': text};

  Detail clone() => Detail(value: value, text: text);

  Detail copyWith({double? value, String? text}) => Detail(
        value: value ?? this.value,
        text: text ?? this.text,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Detail && value == other.value && text == other.text;

  @override
  int get hashCode => value.hashCode ^ text.hashCode;
}
