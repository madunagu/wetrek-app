import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/picture.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/repositories/repository.dart';

class UserRepository extends Repository {
//  late final API api;

  UserRepository(token) : super(token);

  Future<User> current() async {
    final res = await api.get('/user');
    return User.fromJson(res);
  }

  Future<Paginated<User>> list(Parameters params) async {
    final Map<String, dynamic> res = await api.get('/users');

    return Paginated(
      data: (res['data'] as List? ?? []).map((e) => User.fromJson(e)).toList(),
      pagination: Pagination.fromJson(res['pagination']),
    );
  }

  Future<User> get(int id) async {
    final Map<String, dynamic> res = await api.get("/user/$id");
    return User.fromJson(res);
  }

  Future<User> create(Map<String, dynamic> user) async {
    final Map<String, dynamic> res = await api.post('/users', user);
    return User.fromJson(res['data']);
  }

  Future<bool> follow(User user) async {
    return true;
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
        picture: Picture(
          id: 1,
          small: 'https://picsum.photos/100',
          medium: 'https://picsum.photos/200',
          large: 'https://picsum.photos/500',
          full: 'https://picsum.photos/500',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        locations: []);
  }

  List<User> dummies() {
    List<User> treks = [];
    for (int i = 0; i < 10; i++) {
      treks.add(UserRepository.dummy());
    }
    return treks;
  }
}
