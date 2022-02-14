import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController(this.myLocation);

  Address? originAddress;
  Address? destinationAddress;
  Trek? trek;
  Direction? direction;
  String? searchQuery;
  bool? isOriginAddress;
  LatLng myLocation;

  final _searchBarStatusController =
      StreamController<SearchBarStatus>.broadcast();
  final _homePageStatusController =
      StreamController<HomePageStatus>.broadcast();
  final _searchQueryController = StreamController<String>.broadcast();
  final _errorMessageController = StreamController<Exception>.broadcast();
  final _mapLocationController = StreamController<LatLng>.broadcast();

  Stream<SearchBarStatus> get searchBarStatus =>
      _searchBarStatusController.stream;

  Stream<HomePageStatus> get homePageStatus => _homePageStatusController.stream;

  Stream<Exception> get errorMessageStream => _errorMessageController.stream;

  Stream<LatLng> get mapLocationStream => _mapLocationController.stream;

  Stream<String> get searchQueryStream => _searchQueryController.stream;

  SearchBarStatus get lastSearchStatus => _copyStatus;

  SearchBarStatus _copyStatus = SearchBarStatus.normal;

  setLocation(location) => _mapLocationController.add(location);

  search(String? query) {
    log("searching for $query");
    searchQuery = query ?? searchQuery;
    _searchQueryController.sink.add(searchQuery ?? '');
  }

  setHomeStatus(HomePageStatus status) =>
      _homePageStatusController.sink.add(status);

  collapseSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.normal);
    _copyStatus = SearchBarStatus.normal;
  }

  expandSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.expanded);
    _copyStatus = SearchBarStatus.expanded;
  }

  compressSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.compressed);
    _copyStatus = SearchBarStatus.compressed;
  }

  refresh() {
    notifyListeners();
  }

  String destination() {
    return destinationAddress?.description ?? searchQuery ?? '';
  }

  String origin() {
    //TODO: read users location as seed data here
    return originAddress?.description ?? 'Your Location';
  }

  selectTrek(Trek selectedTrek) {
    trek = selectedTrek;
    _homePageStatusController.sink.add(HomePageStatus.showing);
  }

  addError(Exception e) {
    _errorMessageController.add(e);
  }

  getDirection() async {
    if (originAddress == null) {
      _errorMessageController.add(
        UnknownException(message: 'Select Origin Address'),
      );
      return;
    }
    if (destinationAddress == null) {
      _errorMessageController.add(
        UnknownException(message: 'Select Destination Address'),
      );
      return;
    }

    _homePageStatusController.add(HomePageStatus.loading);
    try {
      direction = await MapsRepository.getDirections(
          originAddress!, destinationAddress!);
    } on MyException catch (e, _) {
      print(_);
      _errorMessageController.sink.add(e);
    } catch (e, _) {
      print(_);
      log(_.toString());
      _errorMessageController.add(
          UnknownException(message: 'Couldn\'t Get Directions!. Try Again'));
      _homePageStatusController.add(HomePageStatus.failing);
    }
    _homePageStatusController.add(HomePageStatus.creating);
    _searchBarStatusController.add(SearchBarStatus.compressed);
  }

  selectAddress(Address address) {
    log('Address Is Selecting');
    if (isOriginAddress == null || isOriginAddress == false)
      destinationAddress = address;
    else
      originAddress = address;
    notifyListeners();
  }

  selectDestinationAddress(Address address) {
    destinationAddress = address;
    notifyListeners();
  }

  resetAddress() {
    originAddress = null;
    destinationAddress = null;
  }

  @override
  void dispose() {
    originAddress = null;
    destinationAddress = null;
    trek = null;
    direction = null;
    searchQuery = null;
    _searchBarStatusController.close();
    _homePageStatusController.close();
    _searchQueryController.close();
    _errorMessageController.close();
    _mapLocationController.close();
    super.dispose();
  }
}

enum SearchBarStatus {
  normal,
  expanded,
  compressed,
}

enum HomePageStatus {
  initial,
  searching,
  creating,
  loading,
  waiting,
  showing,
  suggesting,
  selecting,
  failing,
}
