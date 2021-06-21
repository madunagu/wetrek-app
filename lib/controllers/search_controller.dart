import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wetrek/models/address.dart';

class SearchController extends ChangeNotifier {
  SearchBarState? _searchBarState = SearchBarState.searchCollapsed;
  String? searchQuery;
  Address? startAddress;
  Address? endAddress;
  bool? isEndAddress = true;
  final searchController = StreamController<String>.broadcast();

  Stream<String> get searchStream => searchController.stream;

  search(String query) => searchController.sink.add(query);

  open() {
    _searchBarState = SearchBarState.searchOpened;
    notifyListeners();
  }

  resetAddress(){
    startAddress = null;
    endAddress = null;
  }

  close() {
    _searchBarState = SearchBarState.searchCollapsed;
    notifyListeners();
  }

  compress() {
    _searchBarState = SearchBarState.searchCompressed;
    notifyListeners();
  }

  SearchBarState searchBarState() {
    return _searchBarState!;
  }

  selectAddress(Address address) {
    log('Address Is Selecting');
    if (isEndAddress!)
      endAddress = address;
    else
      startAddress = address;
    notifyListeners();
  }

  dispose() {
    _searchBarState = null;
    searchQuery = null;
    isEndAddress = null;
    searchController.close();
    super.dispose();
  }
}

enum SearchBarState {
  searchOpened,
  searchCollapsed,
  searchCompressed,
}
