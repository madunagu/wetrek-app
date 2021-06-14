import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/user.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';

class UserRepository {
  late final API api;
  Future<User> authenticate({
    required String username,
    required String password,
  }) async {
    final Map<String, dynamic> res = await API.postWithoutToken(
      '/login',
      {'email': username, 'password': password},
    );

    return User.fromJson(res);
  }

  Future<List<User>> list(Parameters params) async {
    List<User> users = [];
    final Map<String, dynamic> res = await api.get('/users');
    for (var i = 0; i < res.length; i++) {
      users.add(User.fromJson(res[i]));
    }
    return users;
  }

  Future<User> get(int id) async {
    final Map<String, dynamic> res = await api.get("/user/$id");
    return User.fromJson(res);
  }

  Future<bool> create(User user) async {
    final Map<String, dynamic> res =
        await api.post('/users', jsonEncode(user.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> update(User user) async {
    final Map<String, dynamic> res =
        await api.put("/users/${user.id}", jsonEncode(user.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  static User dummy() {
    return User(
      id: 1,
      name: 'Ekene Madunagu',
      email: 'ekenemadunagu@gmail.com',
      avatar: 'myavatar.com'
    );
  }

  List<User> dummies() {
    List<User> treks = [];
    for (int i = 0; i < 40; i++) {
      treks.add(UserRepository.dummy());
    }
    return treks;
  }
}
