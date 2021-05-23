import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:wetrek/network/api.dart';

abstract class Model {
  static fromJson(json) {}
   toJson() {}
}

abstract class Repository {
  final String endpoint = '/messages';

  Future<List<Model>> list(int id) async {
    List<Model> models = [];
    final Map<String, dynamic> res = await API.get("/messages?chat_id=$id");
    for (var i = 0; i < res.length; i++) {
      models.add(Model.fromJson(res[i]));
    }
    return models;
  }

  Future<Model> get(int id) async {
    final Map<String, dynamic> res = await API.get("/messages/$id");
    return Model.fromJson(res);
  }

  Future<bool> create(Model model) async {
    final Map<String, dynamic> res =
        await API.post(endpoint, jsonEncode(model.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> update(Model trek) async {
    final Map<String, dynamic> res =
        await API.post('/messages', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> deleteTrek(int id) async {
    final Map<String, dynamic> res = await API.delete("/messages/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
