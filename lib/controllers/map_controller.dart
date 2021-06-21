import 'package:flutter/material.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/trek.dart';

class MapController extends ChangeNotifier {
  MapState? _mapState = MapState.initialized;
  Trek? selectedItem;

  search() async {
    _mapState = MapState.searchCompleted;
    notifyListeners();
  }

  suggestAddress() {
    _mapState = MapState.searchSuggested;
    notifyListeners();
  }

  MapState mapState() {
    return _mapState!;
  }

  selectTrek(Trek trek) {
    selectedItem = trek;
    _mapState = MapState.itemSelected;
    notifyListeners();
  }

  createTrek(Address startAddress, Address endAddress) {
    _mapState = MapState.creatingTrek;
    notifyListeners();
  }

  dispose() {
    _mapState = null;
    selectedItem = null;
    super.dispose();
  }
}

enum MapState {
  initialized,
  searchFocused,
  searchCompleted,
  searchSuggested,
  itemSelected,
  creatingTrek,
  waiting,
}
