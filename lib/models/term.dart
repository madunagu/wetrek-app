import 'package:flutter/foundation.dart';

@immutable
class Term {
  const Term({
    required this.value,
    required this.offset,
  });

  final String value;
  final int offset;

  factory Term.fromJson(Map<String, dynamic> json) =>
      Term(value: json['value'] as String, offset: json['offset'] as int);

  Map<String, dynamic> toJson() => {'value': value, 'offset': offset};

  Term clone() => Term(value: value, offset: offset);

  Term copyWith({String? value, int? offset}) => Term(
        value: value ?? this.value,
        offset: offset ?? this.offset,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Term && value == other.value && offset == other.offset;

  @override
  int get hashCode => value.hashCode ^ offset.hashCode;
}
