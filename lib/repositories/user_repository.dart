import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/repositories/repository.dart';

class UserRepository extends Repository {
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

  Future<Paginated<User>> list(Parameters params) async {
//    List<User> users = [];
//    final Map<String, dynamic> res = await api.get('/users');
//    for (var i = 0; i < res.length; i++) {
//      users.add(User.fromJson(res[i]));
//    }

    await Future.delayed(Duration(milliseconds: 100));
    return Paginated<User>(
      data: dummies(),
      pagination: Pagination(
        count: 40,
        currentPage: 1,
        perPage: 40,
        total: 40,
        totalPages: 1,
      ),
    );
//    return Paginated(
//      data: users,
//      pagination: Pagination.fromJson(res['pagination']),
//    );
  }

  Future<User> get(int id) async {
    final Map<String, dynamic> res = await api.get("/user/$id");
    return User.fromJson(res);
  }

  Future<User> create(Model user) async {
    final Map<String, dynamic> res =
        await api.post('/users', jsonEncode(user.toJson()));
    return User.fromJson(res['data']);
  }

  Future<User> update(Model user) async {
    user as User;
    final Map<String, dynamic> res =
        await api.put("/users/${user.id}", jsonEncode(user.toJson()));
    return User.fromJson(res['data']);
  }

  static User dummy() {
    return User(
      id: 1,
      name: 'Ekene Madunagu',
      email: 'ekenemadunagu@gmail.com',
      avatar: 'images/avatar1.jpg',
    );
  }

  List<User> dummies() {
    List<User> treks = [];
    for (int i = 0; i < 10; i++) {
      treks.add(UserRepository.dummy());
    }
    return treks;
  }
}
