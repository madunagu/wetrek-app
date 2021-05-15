import 'package:flutter/material.dart';

class SearchBarController extends ChangeNotifier {
  SearchBarState _searchBarState = SearchBarState.initialized;

  void dropDown() {
    _searchBarState = SearchBarState.opened;
    notifyListeners();
  }

  SearchBarState getState() {
    return _searchBarState;
  }

  void setState(SearchBarState searchBarState) {
    _searchBarState = searchBarState;
    notifyListeners();
  }
}

enum SearchBarState {
  initialized,
  searchFocused,
  searchCompleted,
  markerClicked,
  waiting,
  opened,
}
