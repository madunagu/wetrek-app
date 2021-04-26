import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/widgets/map_widgets.dart';

enum MapState {
  initialized,
  searchFocused,
  markerClicked,
  waiting,
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapState mapState = MapState.waiting;

  Widget switchSheet() {
    switch (mapState) {
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
      case MapState.searchFocused:
        return PlaceDetailsPreview();
      case MapState.waiting:
        return MapSheet(child: TripInfo());
      case MapState.markerClicked:
        return MapSheet(
          child: MapSheetDetails(child: PlaceDetailsPreview()),
        );
      default:
        return MapSheet(
          child: MapSheetDetails(),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: view.height,
        width: view.width,
        color: Colors.white,
        child: Stack(
          children: [
            MapContainer(view: view),
            Positioned(
              top: 36,
              width: view.width,
              height: 52,
              child: SearchBar(),
            ),
            Positioned(
              bottom: 0,
              width: view.width,
              child: switchSheet(),
            ),
          ],
        ),
      ),
    );
  }
}

class MapContainer extends StatefulWidget {
  const MapContainer({
    Key key,
    @required this.view,
  }) : super(key: key);

  final Size view;

  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  GoogleMapController _mapController;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  Completer<GoogleMapController> _controller = Completer();
  String mapStyle;
  void onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    _mapController.setMapStyle(mapStyle);
  }

  void _onMapTap(LatLng point) {
//    if (isTouchable) {
//      _showPointDialog(point);
//    }
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
