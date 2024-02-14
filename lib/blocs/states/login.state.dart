import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';


class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'Password Is Empty';
  }
}

class FirstName extends FormzInput<String, String> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'First Name Is Empty';
  }
}

class LastName extends FormzInput<String, String> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'Last Name Is Empty';
  }
}

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'Email Is Empty';
  }
}

class ConfirmPassword extends FormzInput<String, String> {
  const ConfirmPassword.pure() : super.pure('');
  const ConfirmPassword.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'ConfirmPassword Is Empty';
  }
}

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.password = const Password.pure(),
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.email = const Email.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.validationErrors = const {},
    this.error,
  });

  final FormzStatus status;
  final Password password;
  final FirstName firstName;
  final LastName lastName;
  final Email email;
  final ConfirmPassword confirmPassword;
  final Map<String, dynamic> validationErrors;
  final Exception? error;

  LoginState copyWith({
    FormzStatus? status,
    Password? password,
    FirstName? firstName,
    LastName? lastName,
    Email? email,
    ConfirmPassword? confirmPassword,
    Map<String, dynamic>? validationErrors,
    Exception? error,
  }) {
    return LoginState(
      status: status ?? this.status,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      validationErrors: validationErrors ?? this.validationErrors,
      error: error,
    );
  }

  @override
  List<Object> get props => [status, email, password, validationErrors];
}
