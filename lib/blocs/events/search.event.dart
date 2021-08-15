import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class SearchFetched extends SearchEvent {
  const SearchFetched({this.query});
  final String? query;
  @override
  List<Object> get props => [query ?? ''];
}
