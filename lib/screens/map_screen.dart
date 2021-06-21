import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/controllers/map_controller.dart';
import 'package:wetrek/controllers/search_controller.dart';
import 'package:wetrek/repositories/address_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/widgets/app_navigation_bar.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  static MaterialPageRoute<MapScreen> route() {
    return MaterialPageRoute(builder: (context) => MapScreen());
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController mapController;
  late final SearchController searchController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
    searchController = SearchController();
  }

  @override
  void dispose() {
    mapController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Scaffold(
      drawer: AppNavigationDrawer(),
      body: BlocProvider<ListBloc>(
          create: (context) => ListBloc(repository: TrekRepository()),
          child: Container(
            height: view.height,
            width: view.width,
            color: Colors.white,
            child: Stack(
              children: [
                MapContainer(view: view),
                Positioned(
                  top: 36,
                  width: view.width,
//              height: 52,
                  child: PlaceSearchBar(
                    searchController: searchController,
                    mapController: mapController,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  width: view.width,
                  child: MapLowerSheet(
                    mapController: mapController,
                    searchController: searchController,
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
    required this.mapController,
    required this.searchController,
  }) : super(key: key);

  final MapController mapController;
  final SearchController searchController;

  @override
  _MapLowerSheetState createState() => _MapLowerSheetState();
}

class _MapLowerSheetState extends State<MapLowerSheet> {
  @override
  void initState() {
    super.initState();
    widget.mapController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // mapState = mapController.
    switch (widget.mapController.mapState()) {
      case MapState.initialized:
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
      case MapState.creatingTrek:
        return MapSheet(child: CreateTrek());
      case MapState.searchFocused:
        return Container();
      case MapState.searchCompleted:
        return PlacesNearby(
          searchController: widget.searchController,
          mapController: widget.mapController,
        );
      case MapState.waiting:
        return MapSheet(child: TripInfo());
      case MapState.itemSelected:
        return MapSheet(
          child: MapSheetDetails(
            child: PlaceDetailsPreview(
              trek: widget.mapController.selectedItem!,
            ),
          ),
        );
      case MapState.searchSuggested:
        return BlocProvider<ListBloc>(
          create: (BuildContext context) =>
              ListBloc(repository: AddressRepository()),
          child: SearchResults(searchController: widget.searchController),
        );

      default:
        return MapSheet(child: MapSheetDetails());
    }
  }
}

class MapContainer extends StatefulWidget {
  const MapContainer({
    Key? key,
    required this.view,
  }) : super(key: key);

  final Size view;

  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  late GoogleMapController _googleMapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();
  late String mapStyle;
  void onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
//    _mapController.setMapStyle(mapStyle);
  }

  void _onMapTap(LatLng point) {
//    if (isTouchable) {
//      _showPointDialog(point);
//    }
  }

  void _loadPointers() {}

  @override
  void initState() {
//    _loadMapStyle();
    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _loadMapStyle() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.view.height,
      width: widget.view.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(6.4531, 3.2578),
          zoom: 15,
        ),
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: onMapCreated,
        markers: Set<Marker>.of(markers.values),
        polylines: Set<Polyline>.of(polylines.values),
        onTap: _onMapTap,
      ),
    );
  }
}
