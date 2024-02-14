
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';

abstract class Repository {
  final String endpoint ='';
  late final API api;

  Repository(String token){
    api = API(token);
  }

  Future<Paginated<Model>> list(Parameters params) async {
    return Paginated(
      data: [],
      pagination: Pagination.fromJson({}),
    );
  }

  Future<dynamic> get(int id) async {}

  Future<Model> create(Map<String,dynamic> model) async {
    return Model();
  }

  Future<Model> update(Model model) async {
    return Model();
  }

  Future<bool> deleteTrek(int id) async {
    return false;
  }
}
