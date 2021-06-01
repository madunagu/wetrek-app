import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  const ListEvent();
  @override
  List<Object> get props => [];
}

class ListFetched extends ListEvent {
  const ListFetched({this.query});
  final String? query;
}
