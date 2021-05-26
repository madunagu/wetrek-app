import 'package:flutter/foundation.dart';


@immutable
class Polyline {

  const Polyline({
    required this.points,
  });

  final String points;

  factory Polyline.fromJson(Map<String,dynamic> json) => Polyline(
    points: json['points'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'points': points
  };

  Polyline clone() => Polyline(
    points: points
  );


  Polyline copyWith({
    String? points
  }) => Polyline(
    points: points ?? this.points,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Polyline && points == other.points;

  @override
  int get hashCode => points.hashCode;
}
