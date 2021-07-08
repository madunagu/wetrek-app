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
    String? chatId = params.where['chat_id'];
    await Future.delayed(Duration.zero);
    return Paginated<Message>(
        data: dummies(),
        pagination: Pagination(
          count: 10,
          perPage: 10,
          currentPage: 1,
          total: 40,
          totalPages: 4,
        ));

    dummies();

//    final Map<String, dynamic> res = await api.get("/messages", params: {
//      "chat_id": chatId!,
//      "page": params.page.toString(),
//      "length": params.length.toString(),
//      "q": params.q,
//    });
//
//    return Paginated<Message>.fromJson(res);
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

  Future<Message> create(Map<String,dynamic> message) async {
    final Map<String, dynamic> res =
    await api.post('/messages', jsonEncode(message));
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
      message: mm[i%mm.length],
      modifiedAt: DateTime.now(),
    );
  }

  List<Message> dummies() {
    List<Message> messages = [];
    Random r = Random();
    for (int i = 0; i < 10; i++) {
      messages.add(NotificationRepository.dummy(i: 10));
    }
    return messages;
  }
}
