import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/controllers/home_controller.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/bounds.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/address_repository.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/widgets/app_navigation_bar.dart';
import 'package:wetrek/widgets/map_widgets.dart';
import 'package:wetrek/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  static MaterialPageRoute<MapScreen> route() {
    return MaterialPageRoute(builder: (context) => MapScreen());
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with GoogleMapMixin {
  late final GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  late final HomeController homeController;
  late final String mapStyle;
  late StreamSubscription<HomePageStatus> sub;
  late StreamSubscription<Exception> errorSub;

//  late final GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLines = {};
  @override
  void initState() {
    homeController = HomeController();
    errorSub = homeController.errorMessageStream.listen(showError);
    super.initState();
  }

  showError(Exception e) {
    showDialog(
      context: context,
      builder: (BuildContext context) => NotificationPopup(
        title: 'Error Occurred!',
        body: e.toString(),
      ),
    );
  }

  @override
  void dispose() {
    sub.cancel();
    errorSub.cancel();
    mapController.dispose();
    homeController.dispose();
    super.dispose();
  }

  void onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    log('map created');
    mapController = await _controller.future;
    sub = homeController.homePageStatus.listen(refreshMap);
  }

  void _onMapTap(LatLng point) {
//    if (isTouchable) {
//      _showPointDialog(point);
//    }
  }

  void refreshMap(HomePageStatus status) async {
    if (!_controller.isCompleted) {
      showError(UnknownException(message: 'Google Maps Failure Occured'));
      return;
    }
    switch (status) {
      case HomePageStatus.creating:
        panCamera(
          homeController.direction!.routes[0].bounds,
          mapController,
        );
        setState(() {
          Polyline poly = getPolyline(homeController.direction!);
          polyLines[poly.polylineId] = poly;
          markers.addAll(getMarkers(poly));
        });
        break;
      case HomePageStatus.selecting:
        panCamera(
          homeController.direction!.routes[0].bounds,
          mapController,
        );
        setState(() {
          Polyline poly = getPolyline(homeController.direction!);
          polyLines[poly.polylineId] = poly;
          markers.addAll(getMarkers(poly));
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppNavigationDrawer(),
      body: BlocProvider<ListBloc>(
          create: (context) => ListBloc(
              repository: TrekRepository(
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .token!)),
          child: Container(
            height: view.height,
            width: view.width,
            color: Colors.white,
            child: Stack(
              children: [
                Container(
                  height: view.height,
                  width: view.width,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(6.4584252, 3.2721445),
                      zoom: 15,
                    ),
                    zoomControlsEnabled: false,
                    myLocationEnabled: true,
                    tiltGesturesEnabled: false,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    zoomGesturesEnabled: true,
                    onMapCreated: onMapCreated,
                    rotateGesturesEnabled: false,
                    markers: Set<Marker>.of(markers.values),
                    polylines: Set<Polyline>.of(polyLines.values),
                    onTap: _onMapTap,
                  ),
                ),
                Positioned(
                  top: 36,
                  width: view.width,
//              height: 52,
                  child: PlaceSearchBar(
                    controller: homeController,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: view.width,
                  child: MapLowerSheet(
                    controller: homeController,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class MapLowerSheet extends StatefulWidget {
  const MapLowerSheet({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  _MapLowerSheetState createState() => _MapLowerSheetState();
}

class _MapLowerSheetState extends State<MapLowerSheet> {
  HomePageStatus homePageStatus = HomePageStatus.initial;
  late StreamSubscription<HomePageStatus> sub;
  @override
  void initState() {
    super.initState();
    sub = widget.controller.homePageStatus.listen((status) {
      setState(() {
        homePageStatus = status;
      });
    });
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // mapState = mapController.
    switch (homePageStatus) {
      case HomePageStatus.initial:
        return MapSheet(
          child: MapSheetDetails(
            rightContent: Text(
              '18',
              style: TextStyle(
                color: Color(0xff3D4255),
                fontSize: 62,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      case HomePageStatus.creating:
        return MapSheet(
            child: TrekForm(
          controller: widget.controller,
        ));
      case HomePageStatus.loading:
        return MapSheet(child: CircularProgressIndicator());
      case HomePageStatus.searching:
        return Container();
      case HomePageStatus.showing:
        return PlacesNearby(
          controller: widget.controller,
        );
      case HomePageStatus.waiting:
        return MapSheet(child: TripInfo());
      case HomePageStatus.selecting:
        return MapSheet(
          child: MapSheetDetails(
            child: PlaceDetailsPreview(
              trek: widget.controller.trek!,
            ),
          ),
        );
      case HomePageStatus.suggesting:
        return BlocProvider<ListBloc>(
          create: (BuildContext context) => ListBloc(
            repository: AddressRepository(
                RepositoryProvider.of<AuthenticationRepository>(context).token),
          ),
          child: SearchResults(controller: widget.controller),
        );

      default:
        return MapSheet(child: MapSheetDetails());
    }
  }
}

mixin GoogleMapMixin<T extends StatefulWidget> on State<T> {
  Map<MarkerId, Marker> markAddress(Address address) {
    //add markers on address update
    MarkerId mId = MarkerId(address.placeId);
    Marker m = Marker(
      markerId: mId,
      position: LatLng(
        address.geometry.location.lat,
        address.geometry.location.lng,
      ),
    );
    return {mId: m};
  }

  Polyline getPolyline(Direction direction) {
    String base64Points = direction.routes[0].overviewPolyline.points;

    PolylineId polylineId = PolylineId('only');
    Polyline polyline = Polyline(
      polylineId: polylineId,
      points: decodeEncodedPolyline(base64Points),
      color: Colors.red,
      width: 6,
      visible: true,
      zIndex: 30,
    );
    return polyline;
  }

  Map<MarkerId, Marker> getMarkers(Polyline polyline) {
    Marker originMarker =
        Marker(markerId: MarkerId('origin'), position: polyline.points[0]);
    Marker destinationMarker = Marker(
        markerId: MarkerId('destination'), position: polyline.points.last);
    return {
      originMarker.markerId: originMarker,
      destinationMarker.markerId: destinationMarker
    };
  }

  void panCamera(Bounds bounds, GoogleMapController controller) {
    //here add the polylines
    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(
            bounds.northeast.lat,
            bounds.northeast.lng,
          ),
          southwest: LatLng(
            bounds.southwest.lat,
            bounds.southwest.lng,
          ),
        ),
        1,
      ),
    );
  }

  List<LatLng> decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];

    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    log(poly.toString());
    return poly;
  }

  void _loadPointers() {}

  Future<String> _loadMapStyle() async {
    return await rootBundle.loadString('assets/map_style.txt');
  }
}
