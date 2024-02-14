import 'dart:async';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/user_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final _controller = StreamController<AuthenticationStatus>();
  late String _token;

  Stream<AuthenticationStatus> get status async* {
    String? token = await storage.read(key: 'token');
//    token = 'akkyyad12kidlz';
    if (token != null) {
      _token = token;
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> res = await API.postWithoutToken(
      '/login',
      {'email': email, 'password': password},
    );
    log(res.toString());
    await saveToken(res['token']);

    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> res = await API.postWithoutToken(
      '/register',
      {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password
      },
    );
    log(res.toString());
    await saveToken(res['token']);
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> delete() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<void> saveToken(String token) async {
    _token = token;
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> isCookieSaved(String key) async {
    String? savedCookie = await storage.read(key: key);
    if (savedCookie != null) {
      return true;
    }
    return false;
  }

  Future<void> saveCookie(String key) async {
    await storage.write(key: key, value: 'accepted');
    return;
  }
  void logOut() async {
    await delete();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<User?> getUser() async {
//    return UserRepository.dummy();
    String? token = await storage.read(key: 'token');
    return await UserRepository(token).current();
  }

  void refresh(User u) {
    _controller.add(AuthenticationStatus.authenticated);
  }

  String? get token => _token;
}
