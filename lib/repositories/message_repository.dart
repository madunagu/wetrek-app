import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/message.dart';
import 'package:wetrek/network/api.dart';

class MessageRepository {
  
  Future<List<Message>> getMessages(int id) async {
    List<Message> messages = [];
    final Map<String, dynamic> res = await API.get("/messages?chat_id=$id");
    for (var i = 0; i < res.length; i++) {
      messages.add(Message.fromJson(res[i]));
    }
    return messages;
  }

  Future<Message> getMessage(int id) async {
    final Map<String, dynamic> res = await API.get("/messages/$id");
    return Message.fromJson(res);
  }

  Future<bool> createTrek(Message trek) async {
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
