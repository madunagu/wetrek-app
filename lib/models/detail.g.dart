// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Detail _$DetailFromJson(Map<String, dynamic> json) {
  return Detail()
    ..value = (json['value'] as num)?.toDouble()
    ..text = json['text'] as String;
}

Map<String, dynamic> _$DetailToJson(Detail instance) => <String, dynamic>{
      'value': instance.value,
      'text': instance.text,
    };
