import 'package:flutter/foundation.dart';
import 'Location.dart';
import 'Location.dart';

@immutable
class Bounds {

  const Bounds({
    required this.northeast,
    required this.southwest,
  });

  final Location northeast;
  final Location southwest;

  factory Bounds.fromJson(Map<String,dynamic> json) => Bounds(
    northeast: json['northeast'] as Location,
    southwest: json['southwest'] as Location
  );
  
  Map<String, dynamic> toJson() => {
    'northeast': northeast,
    'southwest': southwest
  };

  Bounds clone() => Bounds(
    northeast: northeast,
    southwest: southwest
  );


  Bounds copyWith({
    Location? northeast,
    Location? southwest
  }) => Bounds(
    northeast: northeast ?? this.northeast,
    southwest: southwest ?? this.southwest,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Bounds && northeast == other.northeast && southwest == other.southwest;

  @override
  int get hashCode => northeast.hashCode ^ southwest.hashCode;
}
