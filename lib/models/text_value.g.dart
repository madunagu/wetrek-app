// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextValue _$TextValueFromJson(Map<String, dynamic> json) {
  return TextValue()
    ..value = (json['value'] as num)?.toDouble()
    ..text = json['text'] as String;
}

Map<String, dynamic> _$TextValueToJson(TextValue instance) => <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
    };
