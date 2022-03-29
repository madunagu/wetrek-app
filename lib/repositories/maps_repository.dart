import 'dart:async';

import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/pagination.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class MapsRepository extends Repository {
  static final String _mapsKey = 'AIzaSyAXYH6jQZSQ6vr6WWgTVpx_Bph2TzEYOY8';

  MapsRepository(token) : super(token);

  static Future<Direction> getDirections(
    Address origin,
    Address destination,
  ) async {
    final Map<String, dynamic> res = await API.getExternal(
      "https://maps.googleapis.com/maps/api/directions/json",
      params: {
        'origin': 'place_id:' + origin.placeId,
        'destination': 'place_id:' + destination.placeId,
        'key': _mapsKey,
      },
    );
    return Direction.fromJson(res);
  }

  Future<Paginated<Address>> list(Parameters p) async {
    final Map<String, dynamic> res = await API.getExternal(
      "https://maps.googleapis.com/maps/api/place/autocomplete/json",
      params: {
//        'locationbias ': 'point:lat,lng',
        'input': p.q,
        'key': _mapsKey,
      },
    );
    return Paginated<Address>(
      data: (res['predictions'] as List? ?? [])
          .map((e) => Address.fromJson(e))
          .toList(),
      pagination: Pagination(
          total: 5, count: 5, perPage: 5, currentPage: 1, totalPages: 2),
    );
  }

  static Future<Map<String, dynamic>> getPlace(String placeId) async {
    final Map<String, dynamic> res = await API.getExternal(
      "https://maps.googleapis.com/maps/api/place/details/json",
      params: {
        'fields ': 'name,rating,formatted_phone_number',
        'place_id': placeId,
        'key': _mapsKey,
      },
    );
    return res;
  }

  static String getPhoto(String referenceId) {
    return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=" +
        referenceId +
        '&key=' +
        _mapsKey;
  }
}
