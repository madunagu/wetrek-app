import 'package:equatable/equatable.dart';
import 'package:wetrek/models/user.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String token;
  final User user;

   AuthenticationSuccess({required this.token, required this.user});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'AuthenticationSuccess { token: $token }';
}

class AuthenticationFailure extends AuthenticationState {}

class AuthenticationInProgress extends AuthenticationState {}
