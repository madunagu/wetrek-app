import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
  @override
  List<Object> get props => [];
}

class SearchTyped extends SearchEvent {
  const SearchTyped({required this.query});
  final String query;
}

class SearchExpanded extends SearchEvent {}

class SearchCompleted extends SearchEvent {}
