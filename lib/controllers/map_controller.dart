import 'package:flutter/material.dart';

class MapController extends ChangeNotifier {
  SearchBarState _searchBarState = SearchBarState.initialized;
  bool _isOpen = false;

  open() {
    _isOpen = true;
    notifyListeners();
  }

  close() {
    _isOpen = false;
    notifyListeners();
  }

  SearchBarState getState() {
    return _searchBarState;
  }

  void setState(SearchBarState searchBarState) {
    _searchBarState = searchBarState;
    notifyListeners();
  }

  bool isOpen() {
    return _isOpen;
  }
}

enum SearchBarState {
  initialized,
  searchFocused,
  searchCompleted,
  markerClicked,
  waiting,
  opened,
  closed,
}
