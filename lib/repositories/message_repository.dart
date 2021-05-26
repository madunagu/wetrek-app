import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/message.dart';
import 'package:wetrek/network/api.dart';

class MessageRepository {
  late final API api;

  Future<List<Message>> getMessages(int id) async {
    List<Message> messages = [];
    final Map<String, dynamic> res = await api.get("/messages");
    for (var i = 0; i < res.length; i++) {
      messages.add(Message.fromJson(res[i]));
    }
    return messages;
  }

  Future<Message> getMessage(int id) async {
    final Map<String, dynamic> res = await api.get("/messages/$id");
    return Message.fromJson(res);
  }

  Future<bool> createTrek(Message trek) async {
    final Map<String, dynamic> res =
        await api.post('/messages', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  Future<bool> deleteTrek(int id) async {
    final Map<String, dynamic> res = await api.delete("/messages/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
