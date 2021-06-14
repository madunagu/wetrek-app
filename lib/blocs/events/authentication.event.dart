import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wetrek/models/user.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationLoggedIn extends AuthenticationEvent {
  final User user;

  const AuthenticationLoggedIn({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'AuthenticationLoggedIn { token: $user.token }';
}

class AuthenticationLoggedOut extends AuthenticationEvent {}
