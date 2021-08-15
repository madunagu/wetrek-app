import 'dart:async';
import 'dart:developer';

import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/blocs/events/login.event.dart';
import 'package:wetrek/blocs/states/login.state.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  LoginState _mapUsernameChangedToState(
    LoginUsernameChanged event,
    LoginState state,
  ) {
    final username = Username.dirty(event.username);
    return state.copyWith(
      username: username,
      status: Formz.validate([state.password, username]),
    );
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.username]),
    );
  }

  Stream<LoginState> _mapLoginSubmittedToState(
    LoginSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.logIn(
          email: state.username.value,
          password: state.password.value,
        );
        yield state.copyWith(
            status: FormzStatus.submissionSuccess, error: null);
      } on ValidationErrorException catch (e, _) {
        log(e.errors.toString());
        yield state.copyWith(
            status: FormzStatus.invalid, validationErrors: e.errors);
      } on MyException catch (e, _) {
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      } on Exception catch (e) {
        log(e.toString());
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      }
    }
  }

  Stream<LoginState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    LoginState state,
  ) async* {
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.signUp(
          firstName: event.firstName,
          lastName: event.lastName,
          email: event.email,
          password: event.password,
        );
        yield state.copyWith(
            status: FormzStatus.submissionSuccess, error: null);
      } on ValidationErrorException catch (e, _) {
        log(e.errors.toString());
        yield state.copyWith(
            status: FormzStatus.invalid, validationErrors: e.errors);
      } on MyException catch (e, _) {
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      } on Exception catch (e) {
        log(e.toString());
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      }
    }
  }
}
