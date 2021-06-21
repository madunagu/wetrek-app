import 'package:flutter/foundation.dart';
import 'package:wetrek/models/model.dart';
import 'pagination.dart';

@immutable
class Paginated<T> {

  const Paginated({
    required this.data,
    required this.pagination,
  });

  final List<T> data;
  final Pagination pagination;

  factory Paginated.fromJson(Map<String,dynamic> json) => Paginated(
    data: (json['data'] as List? ?? []).map((e) => e as T).toList(),
    pagination: json['pagination'] as Pagination
  );
  
  Map<String, dynamic> toJson() => {
    'data': data.map((e) => e.toString()).toList(),
    'pagination': pagination
  };

  Paginated clone() => Paginated(
    data: data.toList(),
    pagination: pagination
  );


  Paginated copyWith({
    List<T>? data,
    Pagination? pagination
  }) => Paginated(
    data: data ?? this.data,
    pagination: pagination ?? this.pagination,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Paginated && data == other.data && pagination == other.pagination;

  @override
  int get hashCode => data.hashCode ^ pagination.hashCode;
}
