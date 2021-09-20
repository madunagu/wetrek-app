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
}


  //  Direction dummy() {
  //   return Direction(geocodedWaypoints: [
  //     Waypoint(
  //       types: ["establishment", "premise"],
  //       geocoderStatus: "OK",
  //       placeId: "ChIJPac_0y-GOxAR-DC8y45ySa0",
  //     ),
  //     Waypoint(
  //       types: ["establishment", "point_of_interest", "transit_station"],
  //       geocoderStatus: "OK",
  //       placeId: "ChIJKcTl0yCGOxARWI_R41rlpsQ",
  //     ),
  //   ], routes: [
  //     Track(
  //       bounds: Bounds(
  //         northeast: Location(lat: 6.4584252, lng: 3.2721445),
  //         southwest: Location(lat: 6.4482876, lng: 3.2487351),
  //       ),
  //       copyrights: 'by google',
  //       legs: [
  //         Leg(
  //           distance: Detail(text: '5.3 km', value: 5317),
  //           duration: Detail(text: '15 mins', value: 895),
  //           endAddress: "Abule Ado Bus Stop, Satellite Town, Lagos, Nigeria",
  //           endLocation: Location(lat: 6.4561927, lng: 3.2562291),
  //           startAddress: "Unipetrol Rd, Satellite Town, Lagos, Nigeria",
  //           startLocation: Location(lat: 6.4482876, lng: 3.2487351),
  //           steps: [
  //             Step(
  //               distance: Detail(text: "0.4 km", value: 435),
  //               duration: Detail(text: '2 mins', value: 118),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.4487388, lng: 3.2526444),
  //               htmlInstructions:
  //                   "Head <b>east</b> on <b>Unipetrol Rd</b><div style=\"font-size:0.9em\">Pass by Jimmy Travels &amp; Tours Limited (on the left)</div>",
  //               polyline: Polyline(
  //                   points:
  //                       "yljf@soyRCg@Ci@?CCc@G_AGiAGoAIkAEi@Ea@Ck@Cc@OqCEw@AE"),
  //               startLocation: Location(lat: 6.4482876, lng: 3.2487351),
  //             ),
  //             Step(
  //               distance: Detail(text: "0.1 km", value: 129),
  //               duration: Detail(text: '1 mins', value: 46),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.449890799999999, lng: 3.2525154),
  //               htmlInstructions:
  //                   "Turn <b>left</b> at Neky Collectibles onto <b>Western Ave</b>",
  //               polyline: Polyline(points: "sojf@_hzRyDPk@D"),
  //               startLocation: Location(lat: 6.4487388, lng: 3.2526444),
  //             ),
  //             Step(
  //               distance: Detail(text: "0.3 km", value: 276),
  //               duration: Detail(text: '1 mins', value: 56),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.452363699999999, lng: 3.252261),
  //               htmlInstructions:
  //                   "At MoMo Agent, continue onto <b>Mobil Rd</b><div style=\"font-size:0.9em\">Pass by St May's Health Shop (on the left)</div>",
  //               polyline:
  //                   Polyline(points: "yvjf@ggzRI@c@BU@qAHm@DgBHc@BaBFY@a@B"),
  //               startLocation: Location(lat: 6.449890799999999, lng: 3.2525154),
  //             ),
  //             Step(
  //               distance: Detail(text: "2.5 km", value: 2529),
  //               duration: Detail(text: '7 mins', value: 422),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.4574191, lng: 3.271859),
  //               htmlInstructions:
  //                   "At Adejare Stores, continue onto <b>Mustapha Ojora St</b><div style=\"font-size:0.9em\">Pass by Lac Vet Stores (on the right)</div>",
  //               polyline: Polyline(
  //                   points:
  //                       "gfkf@sezRI?cCN}@F}ET@HuBJIqAQwBEeAEs@?COuCCYKkBEy@Ey@C]C[C_@?UAMAU?MCUC[?GEc@Eu@?AKyACQK}ACo@Ck@QgC?EC]Cc@Ec@K{AAOQoCAQK}AOkCCk@GaB?CMiBKkBAQCe@IwACc@Co@CWCc@QoCYcEAMAUASGy@SkBGy@[eFEo@CWCc@Cc@IqACy@Ag@AQ?m@?S"),
  //               startLocation: Location(lat: 6.452363699999999, lng: 3.252261),
  //             ),
  //             Step(
  //               distance: Detail(text: "0.2 km", value: 154),
  //               duration: Detail(text: '1 mins', value: 59),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.4582054, lng: 3.2720021),
  //               htmlInstructions:
  //                   "At the roundabout, take the <b>3rd</b> exit<div style=\"font-size:0.9em\">Pass by GROWTH PRINT INTEGRATED SERVICES LIMITED (on the left)</div>",
  //               polyline: Polyline(
  //                   points:
  //                       "{elf@c`~R@@@?@?@?@?@?@?@?@?@A@?@?@A@??A@?@A@A?A@??A@A?A@A?A?A?A?A?A?A?A?A?AAA?AAA?AAA?AA??AA??AA?AAA?AAA?A?A?AAA?A?A?A@A?A?A?A@C@A@A?A@?@A@c@Bc@Bc@Bc@B"),
  //               startLocation: Location(lat: 6.4574191, lng: 3.271859),
  //             ),
  //             Step(
  //               distance: Detail(text: "1.8 km", value: 1794),
  //               duration: Detail(text: '3 mins', value: 194),
  //               travelMode: 'DRIVING',
  //               endLocation: Location(lat: 6.4561927, lng: 3.2562291),
  //               htmlInstructions:
  //                   "At the roundabout, take the <b>2nd</b> exit<div style=\"font-size:0.9em\">Pass by Access Closa Agent (on the right)</div><div style=\"font-size:0.9em\">Destination will be on the right</div>",
  //               polyline: Polyline(
  //                   points:
  //                       "yjlf@_a~R?AA?AAAAA?A?AAA?A?A?A?A?A?A@A?A??@A?A@A@A@A@?@A@?@?@?@A??@?@?@@??@?@?@?@@@?@@??@@@@@@??@@?@@@?@?@@@?@?JJBDDRLj@FZFb@Df@Ff@@LD`@BZ@FB`@@J@TDt@Ft@B\\BXLvBFzA?@B|@?DDdA@@FlAHfA@PHdAHbAD`@?@JdBHbADbADv@Bn@B`@?NN`CBXPdB@RPvBF`ADf@@ZL`CDt@@TB`@?FBXHdA@@RfD?@DbAB`@HdAB^Dv@JtAHfA@L"),
  //               startLocation: Location(lat: 6.4582054, lng: 3.2720021),
  //             ),
  //           ],
  //           trafficSpeedEntry: [],
  //           viaWaypoint: [],
  //         ),
  //       ],
  //       overviewPolyline: Polyline(
  //         points:
  //             "eir~FdezuOndEhaBhjHd~]jsIhmY~nO|qa@ptHhcHlnLnfBb_Tr}AheUoXxrFfdHtvR~tOhoNfuWrqTv|PxxPzlX|`k@fnQ||IfzIbmNr_X~L~vMjoLza@zdKh~CdbFvxGneKjqM~wInsKhtKprMvWl|PzgPx~AtmKhuI~uN|qNn{Tp`FdrP|uDh{QjxCh__Aw[ngWniCbaTnrNryUf\\`d_@nwZ~`LrqBvfEjrF~cHxsWn_IljYxfAvoS|gFv~N`gJllc@|gBvfg@fkFb~RvpIzqGryN~sUnzNnrQn}Rrk\\|iQxli@liKfmm@dyE`tIoYpqWlzNl{SnvG|f[b_Hdtc@f{Fp}j@z~WjpT`cNjwVjpQnsH`sS~aNtkI`|^`zErnm@ddGncP|{@dt[nqRvum@b_Atx^ss@nn|A`Yd_GpgIhzAriG|lSvnTbqh@r{YjuKbqQ|~g@l}^p|e@t|LjrPhlLnsQpqGfuRjrXrd\\zoMzgo@fiJt|OryDnqJhn]|~o@jzIlya@tcb@pdzCheGdeNb}Pr`Bh~A~zc@y{Flcb@qdA~t\\ehBhebAmn@fzm@zzAndXvwBvtn@jrJhzk@ddCxdYr_F~~Vf_BdoTtxQh{OphHrmk@sAlnj@]z~q@pMpt{@j~@feWnzEf|V}oDvjpAeuAhz]`{Ab~c@n~Altj@clBj|w@c}Jb_}A||[dlsBeaA|l]q|FxjNleCtrn@vmElnY~mG|ou@jpHr`u@fjNpcj@{mH`_qC}~@hdcBmDzeWi|GlqYyeJxz`@daHly[kdGfc[zy@nfRhmU`lsAukA`jW{{EnoI|Gf|TylHjs`@~tAvlN_lHdeTgqSn{VolVneMosOf}y@e}Qh{p@e`BvyY~iCtzWhkNny[leOnyOhhL`|XjhFlgSteNfxc@`bPdtn@~cMdo\\f_BbmVvzJ~dYrxCvxJcyH`zWodKj}cA}jOd_|@o{Epui@gzK~nh@cW~rOfyAjgVnDdqSwpEl{LewEpvk@x|A~xc@~kDf|a@g_Ddut@}mI`o^ceCtcX~sHzfd@r_Njye@vzB~r`@hItnn@aeHzqk@~`EzyMzaNlmHlpb@brEjsXp`A~yKtq_@xcAzjf@yxYnlRw`EtkPtTtuKpjDpbSlfL~lgBr|Jhae@|p@di_@dCv|o@cl@rcd@ikJn}d@ubI|raAoaEzyc@yt@rpWrva@jrY~yMpmDf_u@tsi@|_CjpD~uD{kDrfLoaGluP|hPzN~da@hoAjnj@e\\jvKf~JdyFby@|sg@fQ|}D",
  //       ),
  //       summary: 'a summary',
  //       warnings: [],
  //       waypointOrder: [],
  //     )
  //   ], status: 'OK');
  // }
