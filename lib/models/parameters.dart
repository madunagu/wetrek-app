import 'package:flutter/foundation.dart';

@immutable
class Parameters {
  const Parameters({
    this.id,
    this.q = '',
    this.length = 15,
    this.page = 1,
    this.where = const {},
  });

  final int? id;
  final String q;
  final int length;
  final int page;
  final Map<String, dynamic> where;

  factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
        id: json['id'] != null ? json['id'] as int : null,
        q: json['q'] as String,
        length: json['length'] as int,
        page: json['page'] as int,
//    where: (json['where'] as List? ?? []).map((e) => e as String).toList()
      );

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'q': q,
        'length': length.toString(),
        'page': page.toString(),
//    'where': where.map((e) => e.toString()).toList()
      };

  Parameters clone() =>
      Parameters(id: id, q: q, length: length, page: page, where: where);

  Parameters copyWith(
          {int? id,
          String? q,
          int? length,
          int? page,
          Map<String, dynamic>? where}) =>
      Parameters(
        id: id ?? this.id,
        q: q ?? this.q,
        length: length ?? this.length,
        page: page ?? this.page,
        where: where ?? this.where,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Parameters &&
          id == other.id &&
          q == other.q &&
          length == other.length &&
          page == other.page &&
          where == other.where;

  @override
  int get hashCode =>
      id.hashCode ^
      q.hashCode ^
      length.hashCode ^
      page.hashCode ^
      where.hashCode;
}
