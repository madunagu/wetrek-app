import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';

abstract class Repository {
  final String endpoint = '/messages';
  late final API api;
  Future<Paginated> list(Parameters params) async {
    List<Model> models = [];
    final Map<String, dynamic> res =
        await api.get("/messages?chat_id=${params.where['chat_id']}");
    for (var i = 0; i < res.length; i++) {
      models.add(Model.fromJson(res['data'][i]));
    }
    return Paginated(
      data: models,
      pagination: Pagination.fromJson(res['pagination']),
    );
  }

  Future<Model> get(int id) async {
    final Map<String, dynamic> res = await api.get("/messages/$id");
    return Model.fromJson(res);
  }

  Future<bool> create(Model model) async {
    final Map<String, dynamic> res =
        await api.post(endpoint, jsonEncode(model.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> update(Model model) async {
    final Map<String, dynamic> res =
        await api.post('/messages', jsonEncode(model.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> deleteTrek(int id) async {
    final Map<String, dynamic> res = await api.delete("/messages/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
