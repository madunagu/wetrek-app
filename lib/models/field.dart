import 'package:flutter/foundation.dart';


@immutable
class Field {

  const Field({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  final String longName;
  final String shortName;
  final List<String> types;

  factory Field.fromJson(Map<String,dynamic> json) => Field(
    longName: json['long_name'] as String,
    shortName: json['short_name'] as String,
    types: (json['types'] as List? ?? []).map((e) => e as String).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'long_name': longName,
    'short_name': shortName,
    'types': types.map((e) => e.toString()).toList()
  };

  Field clone() => Field(
    longName: longName,
    shortName: shortName,
    types: types.toList()
  );


  Field copyWith({
    String? longName,
    String? shortName,
    List<String>? types
  }) => Field(
    longName: longName ?? this.longName,
    shortName: shortName ?? this.shortName,
    types: types ?? this.types,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Field && longName == other.longName && shortName == other.shortName && types == other.types;

  @override
  int get hashCode => longName.hashCode ^ shortName.hashCode ^ types.hashCode;
}
