import 'package:flutter/foundation.dart';
import 'package:wetrek/models/where.dart';

@immutable
class Parameters {
  const Parameters({
    this.id,
    this.q = '',
    this.length = 15,
    this.page = 1,
    this.conditions = const [],
  });

  final int? id;
  final String q;
  final int length;
  final int page;
  final List<Where> conditions;

  // factory Parameters.fromJson(Map<String, dynamic> json) => Parameters(
  //       id: json['id'] != null ? json['id'] as int : null,
  //       q: json['q'] as String,
  //       length: json['length'] as int,
  //       page: json['page'] as int,
  //       //  where: (json['where'] as List? ?? []).map((e) => Where.fromJson(e)).toList()
  //     );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> fp = {
      'id': id.toString(),
      'q': q,
      'length': length.toString(),
      'page': page.toString(),
    };
    for (Where w in conditions) {
      fp[w.column] = w.val;
    }
    return fp;
  }

  Parameters clone() => Parameters(
      id: id, q: q, length: length, page: page, conditions: conditions);

  Parameters copyWith(
          {int? id,
          String? q,
          int? length,
          int? page,
          List<Where>? conditions}) =>
      Parameters(
        id: id ?? this.id,
        q: q ?? this.q,
        length: length ?? this.length,
        page: page ?? this.page,
        conditions: conditions ?? this.conditions,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Parameters &&
          id == other.id &&
          q == other.q &&
          length == other.length &&
          page == other.page &&
          conditions == other.conditions;

  @override
  int get hashCode =>
      id.hashCode ^
      q.hashCode ^
      length.hashCode ^
      page.hashCode ^
      conditions.hashCode;
}
