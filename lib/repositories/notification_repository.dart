import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:wetrek/models/message.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';
import 'package:wetrek/repositories/user_repository.dart';

class NotificationRepository extends Repository {
  late final API api;

  NotificationRepository(token) : super(token);

  Future<Paginated<Message>> list(Parameters params) async {
    List<Message> messages = [];
//    String? chatId = params.where['chat_id'];
    final Map<String, dynamic> res = await api.get("/messages", params: {
      "page": params.page.toString(),
      "length": params.length.toString(),
      "q": params.q,
    });

    return Paginated<Message>.fromJson(res);
  }

  Future<Paginated> getChats(Parameters params) async {
    List<Message> messages = [];

    final Map<String, dynamic> res = await api.get("/messages", params: {
      "page": params.page.toString(),
      "length": params.length.toString(),
      "q": params.q,
    });

    for (var i = 0; i < res.length; i++) {
      messages.add(Message.fromJson(res['data'][i]));
    }
    return Paginated(
      data: messages,
      pagination: Pagination.fromJson(res['pagination']),
    );
  }

  Future<Message> get(int id) async {
    final Map<String, dynamic> res = await api.get("/messages/$id");
    return Message.fromJson(res);
  }

  Future<Message> create(Map<String, dynamic> message) async {
    final Map<String, dynamic> res = await api.post('/messages', message);
    return Message.fromJson(res['data']);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/messages/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
