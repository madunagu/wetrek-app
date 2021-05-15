// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Step _$StepFromJson(Map<String, dynamic> json) {
  return Step()
    ..distance = json['distance']
    ..duration = json['duration']
    ..endLocation = json['end_location']
    ..htmlInstructions = json['html_instructions'] as String
    ..polyline = json['polyline']
    ..startLocation = json['start_location']
    ..travelMode = json['travel_mode'] as String;
}

Map<String, dynamic> _$StepToJson(Step instance) => <String, dynamic>{
      'distance': instance.distance,
      'duration': instance.duration,
      'end_location': instance.endLocation,
      'html_instructions': instance.htmlInstructions,
      'polyline': instance.polyline,
      'start_location': instance.startLocation,
      'travel_mode': instance.travelMode,
    };
