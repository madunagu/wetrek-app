import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/controllers/home_controller.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/paginated.dart';
import 'package:wetrek/models/parameters.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/screens/phone_screen.dart';
import 'package:wetrek/screens/place_screen.dart';
import 'package:wetrek/screens/terms_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
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

class _MapScreenState extends State<MapScreen> {
  late final HomeController homeController;
  late final User user;
  @override
  void initState() {
    user = BlocProvider.of<AuthenticationBloc>(context).state.user!;
    // checkPhoneNumberSaved();
    checkPrivacyPolicyAccepted();
    locationInit();
    LatLng loc = user.locations.isNotEmpty
        ? user.locations.last.toLatLng()
        : LatLng(6.4584252, 3.2721445);
    homeController = HomeController(loc);
    super.initState();
  }

  void locationInit() async {
    //TODO: write code requesting permision

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  checkPhoneNumberSaved() async {
    if (user.phone == null || user.phone!.isEmpty) {
      Future.delayed(Duration.zero, () {
        Navigator.push(context, PhoneScreen.route());
      });
    }
  }

  checkPrivacyPolicyAccepted() async {
    AuthenticationRepository rep =
        RepositoryProvider.of<AuthenticationRepository>(context);
    bool isPolicyAccepted = await rep.isCookieSaved('privacy_policy');
    if (!isPolicyAccepted) {
      Navigator.push(context, TermsScreen.route());
    }
  }

  @override
  void dispose() {
    homeController.dispose();
    super.dispose();
  }

  void showUserLocation() {
    homeController.setLocation(homeController.myLocation);
  }

  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        repository: TrekRepository(
            RepositoryProvider.of<AuthenticationRepository>(context).token!),
      ),
      child: Scaffold(
        drawer: AppNavigationDrawer(),
        primary: true,
        body: Stack(
          children: [
            GoogleMapContainer(controller: homeController),
            PlaceSearchBar(controller: homeController),
            DraggableScrollableSheet(
                initialChildSize: 0.185,
                minChildSize: 0.185,
                builder: (BuildContext context, ScrollController controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: BottomSheetContainer(
                      controller: homeController,
                      scrollController: controller,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class GoogleMapContainer extends StatefulWidget {
  GoogleMapContainer({required this.controller});
  final HomeController controller;
  @override
  _GoogleMapContainerState createState() => _GoogleMapContainerState();
}

class _GoogleMapContainerState extends State<GoogleMapContainer>
    with GoogleMapMixin {
  late final String _mapStyle;
  late StreamSubscription<HomePageStatus> _sub;
  late StreamSubscription<LatLng> _latLngSub;
  late StreamSubscription<Exception> _errorSub;
  late StreamSubscription<Location> _locationSub;

  late final GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> _markers = {};
  Map<PolylineId, Polyline> _polyLines = {};

  @override
  void initState() {
    _errorSub = widget.controller.errorMessageStream.listen(showError);
    _getCloseTreks();
    super.initState();
  }

  showError(Exception e) {
    if (e is AuthenticationException) {
      showDialog(
        context: context,
        builder: (BuildContext context) => DialogPopup(
          title: 'Error Occurred!',
          body: e.toString(),
          okFunction: () => Navigator.of(context).push(LoginScreen.route()),
          okText: 'LOGOUT',
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopup(
        title: 'Error Occurred!',
        body: e.toString(),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    log('map created');
    _mapController = await _controller.future;
    _sub = widget.controller.homePageStatus.listen(refreshMap);
    _latLngSub = widget.controller.mapLocationStream.listen((LatLng location) {
      _mapController.animateCamera(
        CameraUpdate.newLatLng(location),
      );
    });
  }

  _getCloseTreks() async {
    try {
      String token =
          RepositoryProvider.of<AuthenticationRepository>(context).token!;
      Paginated<Trek> treks = await TrekRepository(token).list(Parameters());
      // BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(size: ui.Size(63, 58), devicePixelRatio: 2),
      //   'assets/marker.png',
      // );
      List<LatLng> _positions = [];
      for (Trek trek in treks.data) {
        MarkerId markerId = MarkerId(trek.id.toString());
        LatLng _pos = _getPos(trek);
        _positions.add(_pos);
        _markers[markerId] = Marker(
          markerId: markerId,
          onTap: () => Navigator.push(context, TrekScreen.route(trek)),
          // icon: customIcon,
          infoWindow: InfoWindow(
            title: trek.name,
            snippet: trek.description,
            onTap: () => Navigator.push(context, TrekScreen.route(trek)),
          ),
          position: _pos,
        );
      }
      _mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          _getBounds(_positions),
          1,
        ),
      );

      setState(() {});
    } on Exception catch (e, _) {
      print(_);
      showError(e);
    } catch (e, _) {
      print(_);
      showError(UnknownException());
    }
  }

  @override
  void dispose() {
    _sub.cancel();
    _errorSub.cancel();
    _locationSub.cancel();
    super.dispose();
  }

  void _onMapTap(LatLng point) {
    //TODO: here show the treks bottom sheet
//    if (isTouchable) {
//      _showPointDialog(point);
//    }
  }

  void refreshMap(HomePageStatus status) async {
    if (!_controller.isCompleted) {
      showError(UnknownException(message: 'Google Maps Failure Occurred'));
      return;
    }
    switch (status) {
      case HomePageStatus.creating:
        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            widget.controller.direction!.routes[0].bounds.toLatLng(),
            1,
          ),
        );
        setState(() {
          Polyline poly = getPolyline(widget.controller.direction!);
          _polyLines[poly.polylineId] = poly;
          _markers.addAll(getMarkers(poly));
        });
        break;
      case HomePageStatus.selecting:
        _mapController.animateCamera(
          CameraUpdate.newLatLngBounds(
            widget.controller.direction!.routes[0].bounds.toLatLng(),
            1,
          ),
        );
        setState(() {
          Polyline poly = getPolyline(widget.controller.direction!);
          _polyLines[poly.polylineId] = poly;
          _markers.addAll(getMarkers(poly));
        });
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size view = MediaQuery.of(context).size;
    return Container(
      height: view.height,
      width: view.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.controller.myLocation,
          //TODO: move away from static zoom
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
        markers: Set<Marker>.of(_markers.values),
        polylines: Set<Polyline>.of(_polyLines.values),
        onTap: _onMapTap,
      ),
    );
  }
}

class BottomSheetContainer extends StatefulWidget {
  const BottomSheetContainer({
    Key? key,
    required this.controller,
    required this.scrollController,
  }) : super(key: key);

  final HomeController controller;
  final ScrollController scrollController;

  @override
  _BottomSheetContainerState createState() => _BottomSheetContainerState();
}

class _BottomSheetContainerState extends State<BottomSheetContainer> {
  HomePageStatus homePageStatus = HomePageStatus.initial;
  late StreamSubscription<HomePageStatus> sub;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    sub = widget.controller.homePageStatus.listen((status) {
      setState(() {
        homePageStatus = status;
      });
    });
    widget.scrollController.addListener(() {
      final maxScroll = widget.scrollController.position.maxScrollExtent;
      final currentScroll = widget.scrollController.offset;
      log(widget.scrollController.position.pixels.toString());
      // if (currentScroll >= (maxScroll * 0.8) && isExpanded == false) {
      //   setState(() {
      //     isExpanded = true;
      //   });
      // }
      //  else if (currentScroll <= (maxScroll * 0.3) && isExpanded == true) {
      //   setState(() {
      //     isExpanded = false;
      //   });
      // }
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
    Size size = MediaQuery.of(context).size;
    switch (homePageStatus) {
      case HomePageStatus.initial:
        return MapSheet(
          controller: widget.controller,
          color: Color(0xff2A2E43),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MapSheetDetails(
                controller: widget.controller,
                // rightContent: Text(
                //   '18',
                //   style: TextStyle(
                //     color: Color(0xff3D4255),
                //     fontSize: 62,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ),
              BlocProvider<SearchBloc>(
                create: (BuildContext context) => SearchBloc(
                  repository: MapsRepository(
                      RepositoryProvider.of<AuthenticationRepository>(context)
                          .token),
                ),
                child: PlacesNearby(controller: widget.controller),
              )
            ],
          ),
        );

      case HomePageStatus.creating:
        return MapSheet(
          controller: widget.controller,
          child: TrekForm(controller: widget.controller),
        );
      case HomePageStatus.loading:
        return MapSheet(
          controller: widget.controller,
          child: Container(height: 200, child: CircularProgressIndicator()),
        );
      case HomePageStatus.searching:
        return Container(
          child: BlocProvider<SearchBloc>(
            create: (BuildContext context) => SearchBloc(
              repository: TrekRepository(
                  RepositoryProvider.of<AuthenticationRepository>(context)
                      .token),
            ),
            child: PlacesNearby(
              controller: widget.controller,
            ),
          ),
        );
      case HomePageStatus.waiting:
        return MapSheet(controller: widget.controller, child: TripInfo());
      case HomePageStatus.showing:
        if (isExpanded) {
          return PlaceScreen(
            place: Address(
                description: 'somewhere', placeId: 'kkk', reference: 'kkk'),
          );
        }
        return MapSheet(
          controller: widget.controller,
          child: MapSheetDetails(
            controller: widget.controller,
            title:
                widget.controller.destinationAddress?.description ?? 'A Place',
            child: Container(
              child: PlaceDetailsPreview(
                place: widget.controller.destinationAddress!,
              ),
            ),
          ),
        );
      case HomePageStatus.suggesting:
        return BlocProvider<SearchBloc>(
          create: (BuildContext context) => SearchBloc(
            repository: MapsRepository(
                RepositoryProvider.of<AuthenticationRepository>(context).token),
          ),
          child: SearchResults(controller: widget.controller),
        );

      default:
        return MapSheet(
          controller: widget.controller,
          child: MapSheetDetails(controller: widget.controller),
        );
    }
  }
}

mixin GoogleMapMixin<T extends StatefulWidget> on State<T> {
//  Map<MarkerId, Marker> markAddress(Address address) {
//    //add markers on address update
//    MarkerId mId = MarkerId(address.placeId);
//    Marker m = Marker(
//      markerId: mId,
//
//      position: LatLng(
//        address.geometry.location.lat,
//        address.geometry.location.lng,
//      ),
//    );
//    return {mId: m};
//  }

  LatLng _getPos(trek) {
    double _lat = 0, _lng = 0;
    if (trek.locations != null && trek.locations!.isNotEmpty) {
      _lat = trek.locations!.last.lat;
      _lng = trek.locations!.last.lng;
    } else if (trek.direction.routes.isNotEmpty) {
      _lat = trek.direction.routes.first.legs.first.startLocation.lat;
      _lng = trek.direction.routes.first.legs.first.startLocation.lng;
    }
    return LatLng(_lat, _lng);
  }

  LatLngBounds _getBounds(List<LatLng> positions) {
    double _maxLat = 0, _maxLng = 0;
    double _minLat = 0, _minLng = 0;
    for (LatLng pos in positions) {
      _maxLat = math.max(_maxLat, pos.latitude);
      _maxLng = math.max(_maxLng, pos.longitude);

      _minLat = math.min(_minLat, pos.latitude);
      _minLng = math.min(_minLat, pos.longitude);
    }
    return LatLngBounds(
      southwest: LatLng(_minLat, _minLng),
      northeast: LatLng(_maxLat, _maxLng),
    );
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
