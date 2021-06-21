import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUsernameChanged extends LoginEvent {
  const LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {
  const LoginSubmitted();
}

class RegisterButtonPressed extends LoginEvent {
  final String name;
  final String email;
  final String phone;

  const RegisterButtonPressed({
    required this.name,
    required this.email,
    required this.phone,
  });

  @override
  List<Object> get props => [name,  email, phone];

  @override
  String toString() =>
      'LoginButtonPressed { name: $name, email: $email, phone: $phone }';
}
