import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/blocs/states/authentication.state.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/token_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final TokenRepository tokenRepository = TokenRepository();
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      final bool hasToken = await tokenRepository.hasToken();

      if (hasToken) {
        String? token = await tokenRepository.get();
        User user = await tokenRepository.getUser();
        yield AuthenticationSuccess(user: user, token: token!);
      } else {
        yield AuthenticationFailure();
      }
    }

    if (event is AuthenticationLoggedIn) {
      yield AuthenticationInProgress();
      await tokenRepository.save(event.user.token!);
      await tokenRepository.saveUser(jsonEncode(event.user.toJson()));
      yield AuthenticationSuccess(user: event.user, token: event.user.token!);
    }


    if (event is AuthenticationLoggedOut) {
      yield AuthenticationInProgress();
      await tokenRepository.delete();
      yield AuthenticationFailure();
    }
  }
}
