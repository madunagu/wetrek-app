import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/User.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';

class TrekRepository {
  static Future<List<Trek>> list() async {
    List<Trek> treks = [];
    final Map<String, dynamic> res = await API.get('/treks');
    for (var i = 0; i < res.length; i++) {
      treks.add(Trek.fromJson(res[i]));
    }
    return treks;
  }

  static Future<Trek> get(int id) async {
    final Map<String, dynamic> res = await API.get("/treks/$id");
    return Trek.fromJson(res);
  }

  static Future<bool> create(Trek trek) async {
    final Map<String, dynamic> res =
        await API.post('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  static Future<bool> update(Trek trek) async {
    final Map<String, dynamic> res =
        await API.put('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  static Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await API.delete("/treks/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
