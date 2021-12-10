import 'dart:async';

import 'package:wetrek/models/notification_container.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class NotificationRepository extends Repository {
  late final API api;

  NotificationRepository(token) : super(token);

  Future<Paginated<NotificationContainer>> list(Parameters params) async {
    final Map<String, dynamic> res = await api.get("/notifications", params: {
      "page": params.page.toString(),
      "length": params.length.toString(),
      "q": params.q,
    });

    return Paginated(
      data: (res['data'] as List? ?? [])
          .map((e) => NotificationContainer.fromJson(e))
          .toList(),
      pagination: Pagination(
          count: 20, currentPage: 1, perPage: 20, total: 20, totalPages: 1),
    );
  }

  Future<NotificationContainer> get(int id) async {
    final Map<String, dynamic> res = await api.get("/notifications/$id");
    return NotificationContainer.fromJson(res);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/notifications/$id");
    return res['data'] == 'true';
  }
}
