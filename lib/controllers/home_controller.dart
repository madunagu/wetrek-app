import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wetrek/models/index.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
//    _searchBarStatusController.sink.add(SearchBarStatus.normal);
//    _homePageStatusController.sink.add(HomePageStatus.initial);
  }

  Address? originAddress;
  Address? destinationAddress;
  Trek? trek;
  Direction? direction;
  String? searchQuery;
  bool? isOriginAddress;

  final _searchBarStatusController =
      StreamController<SearchBarStatus>.broadcast();
  final _homePageStatusController =
      StreamController<HomePageStatus>.broadcast();
  final _searchQueryController = StreamController<String>.broadcast();
  final _errorMessageController = StreamController<Exception>.broadcast();

  Stream<SearchBarStatus> get searchBarStatus =>
      _searchBarStatusController.stream;

  Stream<HomePageStatus> get homePageStatus => _homePageStatusController.stream;

  Stream<Exception> get errorMessageStream => _errorMessageController.stream;

  Stream<String> get searchQueryStream => _searchQueryController.stream;

  search(String query) {
    searchQuery = query;
    _searchQueryController.sink.add(query);
  }

  setHomeStatus(HomePageStatus status) =>
      _homePageStatusController.sink.add(status);

  collapseSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.normal);
  }

  expandSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.expanded);
  }

  compressSearchBar() {
    _searchBarStatusController.sink.add(SearchBarStatus.compressed);
  }

  refresh() {
    notifyListeners();
  }

  String destination() {
    return destinationAddress?.formattedAddress ?? searchQuery ?? '';
  }

  String origin() {
    //TODO: read users location as seed data here
    return originAddress?.formattedAddress ?? 'Your Location';
  }

  selectTrek(Trek trek) {
    trek = trek;
    _homePageStatusController.sink.add(HomePageStatus.selecting);
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
    } on MyException catch (_) {
      _errorMessageController.sink.add(_);
    } catch (_) {
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
