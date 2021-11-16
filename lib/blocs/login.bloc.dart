import 'dart:async';
import 'dart:developer';

import 'package:formz/formz.dart';
import 'package:bloc/bloc.dart';
import 'package:wetrek/blocs/events/login.event.dart';
import 'package:wetrek/blocs/states/login.state.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';

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
    if (event is LoginEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterEmailChanged) {
      yield _mapRegisterEmailChangedToState(event, state);
    } else if (event is LoginPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapRegisterPasswordChangedToState(event, state);
    } else if (event is RegisterFirstNameChanged) {
      yield _mapFirstNameChangedToState(event, state);
    } else if (event is RegisterLastNameChanged) {
      yield _mapLastNameChangedToState(event, state);
    } else if (event is RegisterConfirmPasswordChanged) {
      yield _mapConfirmPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapLoginSubmittedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    }
  }

  LoginState _mapPasswordChangedToState(
    LoginPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([password, state.email]),
    );
  }

  LoginState _mapRegisterPasswordChangedToState(
    RegisterPasswordChanged event,
    LoginState state,
  ) {
    final password = Password.dirty(event.password);
    return state.copyWith(
      password: password,
      status: Formz.validate([
        password,
        state.firstName,
        state.lastName,
        // state.email,
        // state.confirmPassword
      ]),
    );
  }

  LoginState _mapFirstNameChangedToState(
    RegisterFirstNameChanged event,
    LoginState state,
  ) {
    final firstName = FirstName.dirty(event.firstName);
    return state.copyWith(
      firstName: firstName,
      status: Formz.validate([
        firstName,
        state.lastName,
        state.email,
        state.password,
        // state.confirmPassword
      ]),
    );
  }

  LoginState _mapLastNameChangedToState(
    RegisterLastNameChanged event,
    LoginState state,
  ) {
    final lastName = LastName.dirty(event.lastName);
    return state.copyWith(
      lastName: lastName,
      status: Formz.validate([
        lastName,
        state.firstName,
        state.email,
        state.password,
        // state.confirmPassword
      ]),
    );
  }

  LoginState _mapEmailChangedToState(
    LoginEmailChanged event,
    LoginState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([email, state.password]),
    );
  }

  LoginState _mapRegisterEmailChangedToState(
    RegisterEmailChanged event,
    LoginState state,
  ) {
    final email = Email.dirty(event.email);
    return state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.firstName,
        state.lastName,
        state.password,
        // state.confirmPassword
      ]),
    );
  }

  LoginState _mapConfirmPasswordChangedToState(
    RegisterConfirmPasswordChanged event,
    LoginState state,
  ) {
    final confirmPassword = ConfirmPassword.dirty(event.password);
    return state.copyWith(
      confirmPassword: confirmPassword,
      status: Formz.validate([
        confirmPassword,
        // state.firstName,
        // state.lastName,
        // state.email,
        // state.password,
      ]),
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
          email: state.email.value,
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
    } else {
      yield state.copyWith(status: FormzStatus.submissionFailure);
    }
  }

  Stream<LoginState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    LoginState state,
  ) async* {
    log('registering ');
    if (state.status.isValidated) {
      yield state.copyWith(status: FormzStatus.submissionInProgress);
      try {
        await _authenticationRepository.signUp(
          firstName: state.firstName.value,
          lastName: state.lastName.value,
          email: state.email.value,
          password: state.password.value,
        );
        yield state.copyWith(
            status: FormzStatus.submissionSuccess, error: null);
      } on ValidationErrorException catch (e, _) {
        log(e.errors.toString());
        yield state.copyWith(
          status: FormzStatus.invalid,
          validationErrors: e.errors,
        );
      } on MyException catch (e, _) {
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      } on Exception catch (e) {
        log(e.toString());
        yield state.copyWith(status: FormzStatus.submissionFailure, error: e);
      }
    }
  }
}
