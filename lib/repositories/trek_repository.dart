import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/User.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/bounds.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/picture.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/repository.dart';

class TrekRepository extends Repository {
  late final API api;

  TrekRepository(token) : super(token);
  @override
  Future<Paginated<Trek>> list(Parameters params) async {
    final Map<String, dynamic> p = params.toJson();
    final Map<String, dynamic> res = await api.get('/treks',params: p);
    return Paginated(
      data:
      (res['data'] as List? ?? []).map((e) => Trek.fromJson(e)).toList(),
      pagination: Pagination.fromJson(res['pagination']),
    );
//    return Paginated<Trek>.fromJson(res);
  }

  Future<Trek> get(int id) async {
    final Map<String, dynamic> res = await api.get("/treks/$id");
    return Trek.fromJson(res);
  }

  Future<Trek> create(Map<String, dynamic> trek) async {
    final Map<String, dynamic> res = await api.post('/treks', trek);
    return Trek.fromJson(res['data']);
  }

  Future<Trek> update(Model trek) async {
    final Map<String, dynamic> res =
        await api.put('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return Trek.fromJson(res['data']);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/treks/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
