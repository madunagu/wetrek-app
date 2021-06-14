import 'dart:async';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/blocs/events/login.event.dart';
import 'package:wetrek/blocs/states/login.state.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial());

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginInProgress();

      try {
        final User user = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(AuthenticationLoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        log(error.toString());
        yield LoginFailure(error: error.toString());
      }
    }
    if (event is RegisterButtonPressed) {
      yield LoginInProgress();
      try {} catch (error) {}
    }
  }
}
