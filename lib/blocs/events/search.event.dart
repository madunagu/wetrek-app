import 'package:equatable/equatable.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/where.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchEvent {
  const SearchFetched({this.query, this.conditions});
  final String? query;
  final List<Where>? conditions;
  @override
  List<Object> get props => [query ?? ''];
}
