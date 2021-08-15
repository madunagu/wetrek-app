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

class MessageRepository extends Repository {
  late final API api;

  MessageRepository(token) : super(token);

  Future<Paginated<Message>> list(Parameters params) async {
//    await Future.delayed(Duration(seconds: 5));
//    return Paginated<Message>(
//        data: dummies(),
//        pagination: Pagination(
//          count: 10,
//          perPage: 10,
//          currentPage: 1,
//          total: 40,
//          totalPages: 4,
//        ));

    final Map<String, dynamic> res =
        await api.get("/messages", params: params.toJson());

    return Paginated(
      data:
      (res['data'] as List? ?? []).map((e) => Message.fromJson(e)).toList(),
      pagination: Pagination.fromJson(res['pagination']),
    );
  }

  Future<Paginated<Message>> getChats(Parameters params) async {
    final Map<String, dynamic> res = await api.get("/chats", params: {
      "page": params.page.toString(),
      "length": params.length.toString(),
      "q": params.q,
    });
    return Paginated(
      data:
          (res['data'] as List? ?? []).map((e) => Message.fromJson(e)).toList(),
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

  static Message dummy({i = 0}) {
    List<String> mm = [
      'Remember that not getting what you want is sometimes a wonderful stroke of luck.',
      'Hello, how are you doing',
      'Oga, hw far now',
      'We should be able to get there before 6',
      'hello, everyone',
      'We plenty for this group ooo. admin hw far now',
      'I think we should hire a group bus while going'
    ];

    return Message(
      createdAt: DateTime.now(),
      from: UserRepository.dummy(),
      message: "$i " + mm[i % mm.length],
      modifiedAt: DateTime.now(),
      seenAt: [],
      seenBy: [],
    );
  }

  List<Message> dummies() {
    List<Message> messages = [];
    Random r = Random();
    for (int i = 0; i < 10; i++) {
      messages.add(MessageRepository.dummy(i: i));
    }
    return messages;
  }
}
