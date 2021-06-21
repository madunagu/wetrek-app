import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/blocs/states/authentication.state.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required UserRepository userRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
          (status) => add(AuthenticationStatusChanged(status)),
    );
  }

//  @override
//  Stream<AuthenticationState> mapEventToState(
//    AuthenticationEvent event,
//  ) async* {
//    if (event is AuthenticationStarted) {
//      final bool hasToken = await tokenRepository.hasToken();
//
//      if (hasToken) {
//        String? token = await tokenRepository.get();
//        User user = await tokenRepository.getUser();
//        yield AuthenticationSuccess(user: user, token: token!);
//      } else {
//        yield AuthenticationFailure();
//      }
//    }
//
//    if (event is AuthenticationLoggedIn) {
//      yield AuthenticationInProgress();
//      await tokenRepository.save(event.user.token!);
//      await tokenRepository.saveUser(jsonEncode(event.user.toJson()));
//      yield AuthenticationSuccess(user: event.user, token: event.user.token!);
//    }
//
//    if (event is AuthenticationLoggedOut) {
//      yield AuthenticationInProgress();
//      await tokenRepository.delete();
//      yield AuthenticationFailure();
//    }
//  }



  final UserRepository _userRepository;
  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,

  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _authenticationRepository.getUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
