import 'dart:async';

import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/picture.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class ImageRepository extends Repository {
  late final API api;

  ImageRepository(token) : super(token);

  Future<Picture> create(Map<String, dynamic> image) async {
    final Map<String, dynamic> res = await api.post('/images', image);
    return Picture.fromJson(res['data']);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/images/$id");
    return res['data'] == 'true';
  }

}
