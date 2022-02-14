import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';

@immutable
class Picture extends Model {
  const Picture({
    required this.id,
    required this.small,
    required this.medium,
    required this.large,
    required this.full,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String small;
  final String medium;
  final String large;
  final String full;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
      id: json['id'] != null ? json['id'] as int : null,
      small: json['small'] as String,
      medium: json['medium'] as String,
      large: json['large'] as String,
      full: json['full'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String));

  Map<String, dynamic> toJson() => {
        'id': id,
        'small': small,
        'medium': medium,
        'large': large,
        'full': full,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String()
      };

  Picture clone() => Picture(
      id: id,
      small: small,
      medium: medium,
      large: large,
      full: full,
      createdAt: createdAt,
      updatedAt: updatedAt);

  Picture copyWith(
          {int? id,
          String? small,
          String? medium,
          String? large,
          String? full,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Picture(
        id: id ?? this.id,
        small: small ?? this.small,
        medium: medium ?? this.medium,
        large: large ?? this.large,
        full: full ?? this.full,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Picture &&
          id == other.id &&
          small == other.small &&
          medium == other.medium &&
          large == other.large &&
          full == other.full &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      small.hashCode ^
      medium.hashCode ^
      large.hashCode ^
      full.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
