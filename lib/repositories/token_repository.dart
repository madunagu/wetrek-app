import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wetrek/models/user.dart';

class TokenRepository {
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> delete() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<void> saveUser(String user) async {
    await storage.write(key: 'user', value: user);
    return;
  }

  Future<User> getUser() async {
    String? userStr = await storage.read(key: 'user');
    return User.fromJson(jsonDecode(userStr!));
  }

  //TOKEN METHODS

  Future<void> save(String token) async {
    /// write to keystore/keychain
    await storage.write(key: 'token', value: token);
    return;
  }

  Future<bool> hasToken() async {
    bool _hasToken = await storage.read(key: 'token') != null;
    return _hasToken;
  }

  Future<String?> get() async {
    return await storage.read(key: 'token');
  }
}
