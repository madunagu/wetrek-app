import 'package:flutter/foundation.dart';


@immutable
class Picture {

  const Picture({
    required this.avatar,
    required this.small,
    required this.medium,
    required this.large,
    required this.full,
  });

  final String avatar;
  final String small;
  final String medium;
  final String large;
  final String full;

  factory Picture.fromJson(Map<String,dynamic> json) => Picture(
    avatar: json['avatar'] as String,
    small: json['small'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
    full: json['full'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'avatar': avatar,
    'small': small,
    'medium': medium,
    'large': large,
    'full': full
  };

  Picture clone() => Picture(
    avatar: avatar,
    small: small,
    medium: medium,
    large: large,
    full: full
  );


  Picture copyWith({
    String? avatar,
    String? small,
    String? medium,
    String? large,
    String? full
  }) => Picture(
    avatar: avatar ?? this.avatar,
    small: small ?? this.small,
    medium: medium ?? this.medium,
    large: large ?? this.large,
    full: full ?? this.full,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Picture && avatar == other.avatar && small == other.small && medium == other.medium && large == other.large && full == other.full;

  @override
  int get hashCode => avatar.hashCode ^ small.hashCode ^ medium.hashCode ^ large.hashCode ^ full.hashCode;
}
