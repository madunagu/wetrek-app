import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/bounds.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class AddressRepository extends Repository {
  late final API api;

  AddressRepository(token) : super(token);

  Future<Paginated<Address>> list(Parameters params) async {
//    List<Address> addresses = AddressRepository.dummies();

//    final Map<String, dynamic> res = await api.get("/addresses", params: {
//      "page": params.page.toString(),
//      "length": params.length.toString(),
//      "q": params.q,
//    });
//
//    for (var i = 0; i < res.length; i++) {
//      addresses.add(Address.fromJson(res['data'][i]));
//    }
    return Paginated<Address>(
      data: [],
      pagination: Pagination(
        count: 10,
        currentPage: 1,
        perPage: 10,
        total: 10,
        totalPages: 1,
      ),
    );
  }

  Future<Address> get(int id) async {
    final Map<String, dynamic> res = await api.get("/addresses/$id");
    return Address.fromJson(res);
  }

  Future<Address> create(Map<String, dynamic> address) async {
    final Map<String, dynamic> res =
        await api.post('/addresses', address);
    return Address.fromJson(res['data']);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/addresses/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }


}
