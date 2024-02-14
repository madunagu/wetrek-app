import 'dart:async';
import 'package:wetrek/models/settings.dart';
import 'package:wetrek/network/api.dart';

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
