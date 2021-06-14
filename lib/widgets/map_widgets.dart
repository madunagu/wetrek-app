import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/controllers/map_controller.dart';
import 'package:wetrek/controllers/search_controller.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/option.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/presentation/custom_icons.dart';
import 'widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceDetailsPreview extends StatelessWidget {
  PlaceDetailsPreview({required this.trek});
  final Trek trek;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 72,
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 2,
              child: Container(
                height: 44,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset('images/sushi.jpg', height: 44),
                    Image.asset('images/museum.jpg', height: 44),
                    Image.asset('images/ice_cream.jpg', height: 44),
                  ],
                ),
              )),
          Expanded(
            flex: 1,
            child: Container(
              child: MyButton('GO THERE'),
            ),
          )
        ],
      ),
    );
  }
}

class CreateTrek extends StatefulWidget {
  @override
  _CreateTrekState createState() => _CreateTrekState();
}

class _CreateTrekState extends State<CreateTrek> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stepper(
        steps: [
          Step(title: Text('Trek Details'), content: TrekForm()),
          Step(title: Text('Select Ride'), content: ChooseRideType()),
        ],
        type: StepperType.horizontal,
      ),
    );
  }
}

class TrekForm extends StatefulWidget {
  @override
  _TrekFormState createState() => _TrekFormState();
}

class _TrekFormState extends State<TrekForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MapSheet extends StatelessWidget {
  MapSheet({required this.child, this.topBorder = const GradientLine()});
  final Widget child;
  final Widget topBorder;
  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          LocationButton(),
          SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
            child: Column(
              children: [
                topBorder,
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  width: view.width,
                  color: Color(0xff2A2E43),
                  child: child,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 92,
        height: 52,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
        ),
        child: Icon(
          Icons.location_searching,
          color: Color(0xff454F63),
          size: 18,
        ),
      ),
    );
  }
}

class MapSheetDetails extends StatelessWidget {
  const MapSheetDetails({
    Key? key,
    this.child,
    this.title = 'Nearby',
    this.subTitle = 'Foods, drinks, places',
    this.rightContent,
  }) : super(key: key);
  final Widget? child;
  final Widget? rightContent;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              //here expand the size of the sheet
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Icon(
                Icons.keyboard_arrow_up,
                color: Color(0x88ffffff),
              ),
            ),
          ),
          SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.normal,
                ),
                Text(
                  subTitle,
                  style: TextStyles.minor,
                ),
                child != null ? child! : Container(),
              ],
            ),
          ),
          if (rightContent != null) Spacer(),
          rightContent!,
        ],
      ),
    );
  }
}

class PlacesNearby extends StatefulWidget {
  PlacesNearby({required this.searchController, required this.mapController});
  final SearchController searchController;
  final MapController mapController;
  @override
  _PlacesNearbyState createState() => _PlacesNearbyState();
}

class _PlacesNearbyState extends State<PlacesNearby> {
  List<Trek> treks = [];

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late ListBloc _postBloc;
  late final StreamSubscription<String> subscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListBloc>(context);
//    _postBloc.add(ListFetched());
    subscription = widget.searchController.searchStream.listen((query) {
      onSearch(query);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    subscription.cancel();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(ListFetched());
    }
  }

  void onSearch(String query) {
    if (query.length > 3) {
      _postBloc.add(ListFetched(query: query));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ListFailure) {
          //TODO: design widget for this particular function
          //let the popups be for other exceptions
          return Center(
            child: Text('fetch failed'),
          );
        }
        if (state is ListSuccess) {
          if (state.models.isEmpty) {
            return Center(
              child: Text('no messages'),
            );
          }
          return this.cards(state.models);
        }
        return Container();
      },
    );
  }

  Widget cards(List<Model> models) {
    models as List<Trek>;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: models
            .map((e) => GestureDetector(
                  onTap: () => widget.mapController.selectTrek(e),
                  child: PlacedCard(
                    title: e.name,
                    subTitle: e.distance(),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class TripInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //in addition to the 16 by the map sheet widget
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4 mins away',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              height: 27 / 20,
            ),
          ),
          SizedBox(height: 23),
          SubTripRow(),
          // this is the underline
          Container(),
          SubTripRow(),
          SizedBox(height: 12),
          MyButton(
            'CANCEL',
            color: Color(0xff444F63),
          )
        ],
      ),
    );
  }
}

class SubTripRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('images/avatar2.jpg', width: 48, height: 48),
          ),
          SizedBox(width: 16),
          Column(children: [
            Text('Alexa', style: TextStyles.normal),
            Text('4.5 stars', style: TextStyles.minor),
          ]),
          Spacer(),
          MyIconButton(),
          SizedBox(width: 8),
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xff353A50),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.message, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  const MyIconButton({Key? key, this.icon = Icons.phone}) : super(key: key);
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xff353A50),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: Colors.white, size: 16),
    );
  }
}

class OptionCard extends StatelessWidget {
  OptionCard({
    required this.title,
    this.subTitle,
    required this.value,
    required this.controller,
  });
  final Widget title;
  final String? subTitle;
  final TextEditingController controller;
  final String value;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.text = value,
      child: Expanded(
        flex: 1,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: controller.value.text == value
                ? WeTrekColors.yellow
                : Color(0xff454F63),
          ),
          padding: EdgeInsets.only(top: 18, bottom: 13),
          margin: EdgeInsets.only(right: 12),
          child: Column(
            children: [
              title,
              SizedBox(height: 5),
              Text(subTitle!, style: TextStyles.minor),
            ],
          ),
        ),
      ),
    );
  }
}

class ChooseRideType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 32, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectCardGroup(
            children: [
              Option(
                title: Icon(Icons.local_taxi, color: Colors.white),
                subTitle: '15 min',
                value: 'car',
              ),
              Option(
                title: Icon(Icons.directions_walk, color: Colors.white),
                subTitle: '15 min',
                value: 'walk',
              ),
              Option(
                title: Icon(Icons.directions_bus, color: Colors.white),
                subTitle: '15 min',
                value: 'bus',
              ),
            ],
          ),
          SizedBox(height: 19),
          Text('Ride sharing', style: TextStyles.normal),
          SizedBox(height: 19),
          SelectCardGroup(
            children: [
              Option(
                title: Text('Taxi', style: TextStyles.normal),
                subTitle: '15 min',
                value: 'taxi',
              ),
              Option(
                title: Text('Ridy', style: TextStyles.normal),
                subTitle: '15 min',
                value: 'ridy',
              ),
              Option(
                title: Text('AutoM', style: TextStyles.normal),
                subTitle: '15 min',
                value: 'auto',
              ),
            ],
          ),
          SizedBox(height: 40),
          MyButton('CALL TAXI', color: WeTrekColors.yellow)
        ],
      ),
    );
  }
}

class SelectCardGroup extends StatefulWidget {
  const SelectCardGroup({
    Key? key,
    required this.children,
  }) : super(key: key);
  final List<Option> children;

  @override
  _SelectCardGroupState createState() => _SelectCardGroupState();
}

class _SelectCardGroupState extends State<SelectCardGroup> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.children
          .map((Option o) => OptionCard(
                title: o.title,
                value: o.value,
                subTitle: o.subTitle,
                controller: _controller,
              ))
          .toList(),
    );
  }
}

class LocationPairCard extends StatelessWidget {
  LocationPairCard({this.onTap, required this.trek});
  final VoidCallback? onTap;
  final Trek trek;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Color(0x15455B63),
              spreadRadius: 1,
              blurRadius: 16,
              offset: Offset(0, 4),
            )
          ],
        ),
        height: 183,
        padding: EdgeInsets.only(left: 20, right: 16, top: 13, bottom: 15),
        child: Row(
          children: [
            MovementDrawing(height: 73, width: 10),
            SizedBox(width: 20),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start Location', style: TextStyles.darkMinor),
                    Text('Fresh Market', style: TextStyles.darkNormal),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      height: 1,
                      color: Color(0xffF4F4F6),
                    ),
                    Text(
                      'Destination Location',
                      style: TextStyles.darkMinor,
                    ),
                    Text('My Home', style: TextStyles.darkNormal),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      height: 1,
                      color: Color(0xffF4F4F6),
                    ),
                    Container(
                      child: Row(
                        children: [
                          AvatarList(
                            imgSrcs: [
                              'images/avatar1.jpg',
                              'images/avatar2.jpg',
                              'images/avatar3.jpg',
                            ],
                          ),
                          Text(
                            'Ekene is attending',
                            style: TextStyles.darkMinor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaceSearchBar extends StatefulWidget {
  PlaceSearchBar({
    required this.mapController,
    required this.searchController,
  });
  final MapController mapController;
  final SearchController searchController;

  @override
  _PlaceSearchBarState createState() => _PlaceSearchBarState();
}

class _PlaceSearchBarState extends State<PlaceSearchBar> {
  @override
  void initState() {
    super.initState();

    widget.searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: currentSearchWidget(),
    );
  }

  Widget currentSearchWidget() {
    switch (widget.searchController.searchBarState()) {
      case SearchBarState.searchOpened:
        return OpenedSearchBar(
          searchController: widget.searchController,
          mapController: widget.mapController,
        );
      case SearchBarState.searchCompressed:
        return CompressedSearchBar(searchController: widget.searchController);
      case SearchBarState.searchCollapsed:
        return CollapsedSearchBar(
          searchController: widget.searchController,
          mapController: widget.mapController,
        );

      default:
        return CollapsedSearchBar(
          searchController: widget.searchController,
          mapController: widget.mapController,
        );
    }
  }
}

class CompressedSearchBar extends StatelessWidget {
  CompressedSearchBar({required this.searchController});
  final SearchController searchController;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: searchController.open,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              CustomIcons.icons_dark_back,
              color: Color(0xff454F63),
            ),
          ),
        ),
        Container(
          height: 24,
          margin: EdgeInsets.only(top: 16, bottom: 16),
          color: Color(0xffF4F4F6),
          width: 1,
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                style: TextStyles.darkNormal.copyWith(color: Color(0xff78849E)),
                text: searchController.startAddress?.toString() != null
                    ? searchController.startAddress!.formattedAddress
                    : 'Your Location',
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Icon(CustomIcons.icons_dark_next, color: Color(0x2e78849E)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(fontSize: 12.0),
              text: TextSpan(
                style: TextStyles.darkNormal,
                text: searchController.endAddress?.toString() != null
                    ? searchController.endAddress!.formattedAddress
                    : 'Your Location',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CollapsedSearchBar extends StatefulWidget {
  CollapsedSearchBar({
    required this.searchController,
    required this.mapController,
  });
  final SearchController searchController;
  final MapController mapController;

  @override
  _CollapsedSearchBarState createState() => _CollapsedSearchBarState();
}

class _CollapsedSearchBarState extends State<CollapsedSearchBar> {
  late final TextEditingController searchToTextController;

  @override
  void initState() {
    searchToTextController =
        TextEditingController(text: widget.searchController.searchQuery);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Icon(
              CustomIcons.icons_dark_menu,
              color: Color(0xff454F63),
            ),
          ),
        ),
        Container(
          height: 24,
          margin: EdgeInsets.only(top: 16, bottom: 16),
          color: Color(0xffF4F4F6),
          width: 1,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0, left: 16, bottom: 6),
            child: TextField(
              onChanged: widget.searchController.search,
              onTap: widget.mapController.search,
              controller: searchToTextController,
              style: TextStyles.darkNormal,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Where To?',
                hintStyle: TextStyles.darkNormal.copyWith(
                  color: Color(0xff78849E),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.searchController.open,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(CustomIcons.icons_dark_add, color: Color(0xff454F63)),
          ),
        ),
      ],
    );
  }
}

class OpenedSearchBar extends StatefulWidget {
  OpenedSearchBar(
      {required this.searchController, required this.mapController});
  final SearchController searchController;
  final MapController mapController;

  @override
  _OpenedSearchBarState createState() => _OpenedSearchBarState();
}

class _OpenedSearchBarState extends State<OpenedSearchBar> {
  final TextEditingController _searchFromTextController =
      TextEditingController();
  final TextEditingController _searchToTextController = TextEditingController();
  bool _fromEnabled = false;
  bool _toEnabled = true;
//  Address? startAddress;
//  Address? endAddress;
  String? _fromError;
  String? _toError;
  @override
  void initState() {
    _updateTextAddress();

    widget.searchController.addListener(() {
      _toEnabled = widget.searchController.endAddress == null;
      _fromEnabled = widget.searchController.startAddress == null;
      _fromError = _toError = null;
//      showCurrentAddress();
//      setState(() {});
    });
    super.initState();
  }

  _updateTextAddress() {
    _searchFromTextController.text =
        widget.searchController.startAddress?.formattedAddress ?? '';
    _searchToTextController.text =
        widget.searchController.endAddress?.formattedAddress ??
            widget.searchController.searchQuery ??
            '';
  }

  @override
  void dispose() {
    _searchToTextController.dispose();
    _searchFromTextController.dispose();
    super.dispose();
  }

  void _createTrek() {
    if (widget.searchController.endAddress == null) {
      // TODO : throw text editor error that text is required
      _toError = 'Select a Valid Address';
//      setState(() {});
      return;
    }
    if (widget.searchController.startAddress == null) {
      // TODO : throw text editor error that text is required
      _fromError = 'Select a Valid Address';
//      setState(() {});
      return;
    }
    widget.mapController.createTrek(widget.searchController.startAddress!,
        widget.searchController.endAddress!);
    widget.searchController.compress();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
//      height: 133,
      padding: EdgeInsets.only(
        left: 24,
      ),
      child: Row(
        children: [
          MovementDrawing(height: 73, width: 10),
          SizedBox(width: 20),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyles.darkNormal,
                          onChanged: widget.searchController.search,
                          onTap: () {
                            widget.searchController.isEndAddress = false;
                            widget.mapController.suggestAddress();
                          },
                          controller: _searchFromTextController,
                          enabled: _fromEnabled,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            labelText: 'From',
                            labelStyle: TextStyles.darkMinor,
                            border: InputBorder.none,
                            fillColor: Color(0x2f3ACCE1),
                            filled: !_fromEnabled,
                            alignLabelWithHint: true,
                            errorText: _fromError,
                            errorStyle: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _fromEnabled = true;
                          _toEnabled = true;
                          setState(() {});
                        },
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            CustomIcons.icons_dark_close,
                            color: Color(0xff454F63),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    height: 1,
                    color: Color(0xffF4F4F6),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyles.darkNormal,
                          onChanged: widget.searchController.search,
                          enabled: _toEnabled,
                          onTap: () {
                            widget.searchController.isEndAddress = true;
                            widget.mapController.suggestAddress();
                          },
                          controller: _searchToTextController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            fillColor: Color(0x2f3ACCE1),
                            filled: !_toEnabled,
                            labelText: 'To',
                            labelStyle: TextStyles.darkMinor,
                            border: InputBorder.none,
                            errorStyle: TextStyle(color: Colors.red),
                            errorText: _toError,
                            enabled: _toEnabled,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _createTrek,
                        child: Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.all(16),
                          child: Icon(
                            Icons.done,
                            color: Color(0xff454F63),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResults extends StatefulWidget {
  SearchResults({required this.searchController});
  final SearchController searchController;
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Address> results = [];
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  late ListBloc _postBloc;

  late final StreamSubscription<String> searchSubscription;
  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListBloc>(context);
//    _postBloc.add(ListFetched());
    searchSubscription = widget.searchController.searchStream.listen((query) {
      onSearch(query);
    });

    super.initState();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postBloc.add(ListFetched());
    }
  }

  void onSearch(String query) {
    if (query.length > 3) {
      _postBloc.add(ListFetched(query: query));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  List<Widget> addresses(List<Model> models) {
    models as List<Address>;
    return models
        .map(
          (e) => GestureDetector(
            onTap: () => widget.searchController.selectAddress(e),
            child: SearchResultRow(e),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        if (state is ListInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ListFailure) {
          //TODO: design widget for this particular function
          //let the popups be for other exceptions
          return Center(
            child: Text('fetch failed'),
          );
        }
        if (state is ListSuccess) {
          if (state.models.isEmpty) {
            return Center(
              child: Text('no messages'),
            );
          }
          return Container(
            color: Color(0xffF7F7FA),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: 200,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SEARCH RESULTS',
                    style: TextStyle(
                      color: Color(0x9278849E),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ...addresses(state.models),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class SearchResultRow extends StatelessWidget {
  SearchResultRow(this.address);
  final Address address;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 16),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Color(0x1578849E),
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.formattedAddress, style: TextStyles.darkNormal),
                Text('2Km.', style: TextStyles.darkMinor),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Color(0xff454F63)),
        ],
      ),
    );
  }
}
