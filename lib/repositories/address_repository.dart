import 'dart:async';
import 'dart:convert';

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
import 'package:wetrek/network/api.dart';
import 'package:wetrek/repositories/repository.dart';

class AddressRepository extends Repository {
  late final API api;

  Future<Paginated> list(Parameters params) async {
    List<Address> addresses = AddressRepository.dummies();

//    final Map<String, dynamic> res = await api.get("/addresses", params: {
//      "page": params.page.toString(),
//      "length": params.length.toString(),
//      "q": params.q,
//    });
//
//    for (var i = 0; i < res.length; i++) {
//      addresses.add(Address.fromJson(res['data'][i]));
//    }
    return Paginated(
      data: addresses,
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

  Future<Address> create(Model address) async {
    final Map<String, dynamic> res =
        await api.post('/addresses', jsonEncode(address.toJson()));
    return Address.fromJson(res['data']);
  }

  Future<bool> delete(int id) async {
    final Map<String, dynamic> res = await api.delete("/addresses/$id");
    //TODO: chech if boolean true is parsed already
    return res['success'] == 'true';
  }

  static Address dummy() {
    return Address(
        formattedAddress: 'Winnetka, Los Angeles, CA, USA',
        placeId: 'ChIJ0fd4S_KbwoAR2hRDrsr3HmQ',
        types: ['neighborhood', 'political'],
        geometry: Geometry(
          location: Location(lng: 133.333, lat: 133.323),
          locationType: 'political',
          viewport: Bounds(
            northeast: Location(lng: 133.333, lat: 133.323),
            southwest: Location(lng: 133.333, lat: 133.323),
          ),
        ),
        plusCode: PlusCode(compoundCode: 'kkk', globalCode: 'jj'),
        addressComponents: [
          Field(
            longName: 'Winnetka',
            shortName: 'Winnetka',
            types: ['neighborhood', 'political'],
          ),
          Field(
            longName: 'Los Angeles',
            shortName: 'LA',
            types: ['locality', 'political'],
          ),
          Field(
            longName: 'California',
            shortName: 'CA',
            types: ['administrative_area_level_1', 'political'],
          ),
        ]);
//    return Address.fromJson(jsonDecode('''{
//         "address_components" : [
//            {
//               "long_name" : "Winnetka",
//               "short_name" : "Winnetka",
//               "types" : [ "neighborhood", "political" ]
//            },
//            {
//               "long_name" : "Los Angeles",
//               "short_name" : "LA",
//               "types" : [ "locality", "political" ]
//            },
//            {
//               "long_name" : "Los Angeles County",
//               "short_name" : "Los Angeles County",
//               "types" : [ "administrative_area_level_2", "political" ]
//            },
//            {
//               "long_name" : "California",
//               "short_name" : "CA",
//               "types" : [ "administrative_area_level_1", "political" ]
//            },
//            {
//               "long_name" : "United States",
//               "short_name" : "US",
//               "types" : [ "country", "political" ]
//            }
//         ],
//         "formatted_address" : "Winnetka, Los Angeles, CA, USA",
//         "geometry" : {
//            "bounds" : {
//               "northeast" : {
//                  "lat" : 34.2355209,
//                  "lng" : -118.5534191
//               },
//               "southwest" : {
//                  "lat" : 34.1854649,
//                  "lng" : -118.588536
//               }
//            },
//            "location" : {
//               "lat" : 34.2048586,
//               "lng" : -118.5739621
//            },
//            "location_type" : "APPROXIMATE",
//            "viewport" : {
//               "northeast" : {
//                  "lat" : 34.2355209,
//                  "lng" : -118.5534191
//               },
//               "southwest" : {
//                  "lat" : 34.1854649,
//                  "lng" : -118.588536
//               }
//            }
//         },
//         "place_id" : "ChIJ0fd4S_KbwoAR2hRDrsr3HmQ",
//         "types" : [ "neighborhood", "political" ]
//      }'''));
  }

  static List<Address> dummies() {
    List<Address> addresses = [];
    for (int i = 0; i < 10; i++) {
      addresses.add(AddressRepository.dummy());
    }
    return addresses;
  }
}
