import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:wetrek/network/exceptions.dart';

class Username extends FormzInput<String, String> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'Username Is Empty';
  }
}

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'Password Is Empty';
  }
}

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.validationErrors = const {},
    this.error,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final Map<String, dynamic> validationErrors;
  final Exception? error;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    Map<String, dynamic>? validationErrors,
    Exception? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      validationErrors: validationErrors ?? this.validationErrors,
      error: error,
    );
  }

  @override
  List<Object> get props => [status, username, password, validationErrors];
}
