import 'dart:async';
import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/settings.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class MessageRepository {
  late final API api;

  MessageRepository(token) {
    api = API(token);
  }

  Future<Settings> getSetting(int id) async {
    final Map<String, dynamic> res = await api.get("/settings/$id");
    return Settings.fromJson(res['data']);
  }
  // Future<Message> get(int id) async {
  //   final Map<String, dynamic> res = await api.get("/messages/$id");
  //   return Message.fromJson(res);
  // }

  Future<Settings> update(Map<String, dynamic> settings) async {
    final Map<String, dynamic> res = await api.post('/settings', settings);

    return Settings.fromJson(res['data']);
  }
}
