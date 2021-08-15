import 'package:flutter/foundation.dart';


@immutable
class Match {

  const Match({
    required this.length,
    required this.offset,
  });

  final int length;
  final int offset;

  factory Match.fromJson(Map<String,dynamic> json) => Match(
    length: json['length'] as int,
    offset: json['offset'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'length': length,
    'offset': offset
  };

  Match clone() => Match(
    length: length,
    offset: offset
  );


  Match copyWith({
    int? length,
    int? offset
  }) => Match(
    length: length ?? this.length,
    offset: offset ?? this.offset,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Match && length == other.length && offset == other.offset;

  @override
  int get hashCode => length.hashCode ^ offset.hashCode;
}
