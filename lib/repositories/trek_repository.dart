import 'dart:async';
import 'dart:convert';

import 'package:wetrek/models/User.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/bounds.dart';
import 'package:wetrek/models/field.dart';
import 'package:wetrek/models/geometry.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/plus_code.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/api.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/repositories/repository.dart';

class TrekRepository extends Repository {
  late final API api;
  @override
  Future<Paginated> list(Parameters params) async {
//    List<Trek> treks = [];
//    final Map<String, dynamic> res = await api.get('/treks');
//    for (var i = 0; i < res.length; i++) {
//      treks.add(Trek.fromJson(res['data'][i]));
//    }
  await Future.delayed(Duration(milliseconds: 100));
    return Paginated(
      data: dummies(),
      pagination: Pagination(
        count: 40,
        currentPage: 1,
        perPage: 40,
        total: 40,
        totalPages: 1,
      ),
    );
  }

  Future<Trek> get(int id) async {
    final Map<String, dynamic> res = await api.get("/treks/$id");
    return Trek.fromJson(res);
  }

  Future<Trek> create(Model trek) async {
    final Map<String, dynamic> res =
        await api.post('/treks', jsonEncode(trek.toJson()));
    return Trek.fromJson(res['data']);
  }

  Future<Trek> update(Model trek) async {
    final Map<String, dynamic> res =
        await api.put('/treks', jsonEncode(trek.toJson()));
    //TODO: chech if boolean true is parsed already
    return Trek.fromJson(res['data']);
  }

  static Trek dummy() {
    return Trek(
      createdAt: DateTime.now(),
      locations: [],
      startAddress: Address(
        plusCode: PlusCode(compoundCode: 'kkk', globalCode: 'jj'),
        formattedAddress: 'where',
        placeId: '2343',
        types: ['Political'],
        addressComponents: [
          Field(
            longName: 'longName',
            shortName: 'shortName',
            types: ['political'],
          )
        ],
        geometry: Geometry(
          location: Location(lng: 133.333, lat: 133.323),
          locationType: 'political',
          viewport: Bounds(
            northeast: Location(lng: 133.333, lat: 133.323),
            southwest: Location(lng: 133.333, lat: 133.323),
          ),
        ),
      ),
      endAddress: Address(
        plusCode: PlusCode(compoundCode: 'kkk', globalCode: 'jj'),
        formattedAddress: 'where',
        placeId: '2343',
        types: ['Political'],
        addressComponents: [
          Field(
            longName: 'longName',
            shortName: 'shortName',
            types: ['political'],
          )
        ],
        geometry: Geometry(
          location: Location(lng: 133.333, lat: 133.323),
          locationType: 'political',
          viewport: Bounds(
            northeast: Location(lng: 133.333, lat: 133.323),
            southwest: Location(lng: 133.333, lat: 133.323),
          ),
        ),
      ),
      name: 'Abule ado trek',
      startingAt: DateTime.now(),
    );
  }

  List<Trek> dummies() {
    List<Trek> treks = [];
    for (int i = 0; i < 40; i++) {
      treks.add(TrekRepository.dummy());
    }
    return treks;
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/treks/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }
}
