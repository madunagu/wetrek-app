import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/User.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/repositories/repository.dart';

class TrekRepository extends Repository {
  late final API api;
  @override
  Future<Paginated> list(Parameters params) async {
    List<Trek> treks = [];
    final Map<String, dynamic> res = await api.get('/treks');
    for (var i = 0; i < res.length; i++) {
      treks.add(Trek.fromJson(res['data'][i]));
    }
    return Paginated(
      data: treks,
      pagination: res['pagination'],
    );
  }

  Future<Trek> get(int id) async {
    final Map<String, dynamic> res = await api.get("/treks/$id");
    return Trek.fromJson(res);
  }

  Future<bool> create(Model trek) async {
    final Map<String, dynamic> res =
        await api.post('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> update(Model trek) async {
    final Map<String, dynamic> res =
        await api.put('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/treks/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
