import 'dart:async';
import 'dart:convert';
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
    User? user = await getUser();
    if (user != null) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> res = await API.postWithoutToken(
      '/login',
      {'email': username, 'password': password},
    );
    log(res.toString());
    await saveToken(res['token']);

//    await Future.delayed(const Duration(milliseconds: 300));
    _controller.add(AuthenticationStatus.authenticated);
  }

  Future<void> delete() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
    return;
  }

  void logOut() async {
    await delete();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();

  Future<User?> getUser() async {
//    String? userStr = await storage.read(key: 'user');
//    if (userStr != null) {
//      return User.fromJson(jsonDecode(userStr));
//    }
    log('Get User Called');
    String? t = await storage.read(key: 'token');
    if (t == null) return null;
    _token = t;
    return UserRepository(_token).current();
  }

  String? get token => _token;
}
