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
    return Paginated(
      data: [],
      pagination: Pagination.fromJson({}),
    );
  }

  Future<dynamic> get(int id) async {}

  Future<Model> create(Model model) async {
    return Model();
  }

  Future<Model> update(Model model) async {
    return Model();
  }

  Future<bool> deleteTrek(int id) async {
    return false;
  }
}
