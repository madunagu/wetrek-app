import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/events/list.event.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/list.bloc.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/list.state.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/controllers/home_controller.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/model.dart';
import 'package:wetrek/models/option.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/presentation/custom_icons.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/path_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
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
                children: trek.pictures != null && trek.pictures!.isNotEmpty
                    ? trek.pictures!
                        .map((e) => Image.network(e.small, height: 44))
                        .toList()
                    : [],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(TrekScreen.route(trek));
              },
              child: Container(
                child: MyButton('GO THERE'),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TrekForm extends StatefulWidget {
  TrekForm({required this.controller});

  final HomeController controller;
  @override
  _TrekFormState createState() => _TrekFormState();
}

class _TrekFormState extends State<TrekForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _startingAtController;
  bool isLoading = false;

  @override
  void initState() {
    _titleController = TextEditingController();
    _startingAtController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _startingAtController.dispose();
    super.dispose();
  }

  createTrek() async {
    isLoading = true;
    Map<String, String> data = {
      "starting_at": _startingAtController.value.text,
      "name": _titleController.value.text,
      "start_address": widget.controller.originAddress!.toJson().toString(),
      "end_address": widget.controller.originAddress!.toJson().toString(),
      "directions": widget.controller.direction!.toJson().toString(),
    };
    print(data);
    try {
      Trek trek = await TrekRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!)
          .create(data);
      Navigator.push(context, TrekScreen.route(trek));
    } on Exception catch (e) {
      isLoading = false;
      widget.controller.addError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyInput(
            controller: _titleController,
            isDark: true,
            hintText: 'Trek Title',
          ),
          Text('Starting At', style: TextStyles.normal),
          MyTimePicker(_startingAtController),
          MyButton(
            'Continue',
            isLarge: true,
            isLoading: isLoading,
            onTap: isLoading ? null : createTrek,
          ),
        ],
      ),
    );
  }
}

class MapSheet extends StatelessWidget {
  MapSheet({
    required this.child,
    this.height = 101,
    this.topBorder = const GradientLine(),
  });
  final Widget child;
  final Widget topBorder;
  final double height;
  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Container(
      width: view.width,
      alignment: Alignment.bottomCenter,
      height: height,
      child: ClipRRect(
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
              alignment: Alignment.bottomCenter,
              color: Color(0xff2A2E43),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}

class LocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        Icons.my_location,
        color: Color(0xff454F63),
        size: 18,
      ),
    );
  }
}

class MapSheetDetails extends StatelessWidget {
  const MapSheetDetails({
    Key? key,
    required this.controller,
    this.child,
    this.title = 'Nearby',
    this.subTitle = 'Foods, drinks, places',
    this.rightContent,
  }) : super(key: key);
  final Widget? child;
  final Widget? rightContent;
  final String title;
  final String subTitle;
  final HomeController controller;

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
            onTap: () => this.controller.search,
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
          rightContent ?? Container(),
        ],
      ),
    );
  }
}

class PlacesNearby extends StatefulWidget {
  PlacesNearby({
    required this.controller,
  });
  final HomeController controller;
  @override
  _PlacesNearbyState createState() => _PlacesNearbyState();
}

class _PlacesNearbyState extends State<PlacesNearby> {
  final _scrollController = ScrollController();
  late SearchBloc _searchBloc;
  late final StreamSubscription<String> subscription;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _searchBloc = BlocProvider.of<SearchBloc>(context);
//    _postBloc.add(ListFetched());
    subscription = widget.controller.searchQueryStream.listen((query) {
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
    if (_isBottom) _searchBloc.add(SearchFetched());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void onSearch(String query) {
    _searchBloc.add(SearchFetched(query: query));
  }

  String distance(trek) {
    return '200km';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case SearchStatus.failure:
              return const Center(child: Text('failed to fetch suggestions'));
            case SearchStatus.success:
              if (state.models.isEmpty) {
                return const Center(child: Text('no suggestions'));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.models.length
                      ? BottomLoader()
                      : GestureDetector(
                          onTap: () => widget.controller
                              .selectTrek(state.models[index] as Trek),
                          child: PlacedCard(
                            title: (state.models[index] as Trek).name,
                            subTitle: distance(state.models[index] as Trek),
                          ),
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.models.length
                    : state.models.length + 1,
                controller: _scrollController,
              );
            default:
              return const Center(child: CircularProgressIndicator());
          }
        },
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

class TrekCard extends StatelessWidget {
  TrekCard({this.onTap, required this.trek});
  final VoidCallback? onTap;
  final Trek trek;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
        child: Column(
          children: [
            LocationPairCard(
              originAddress: trek.startAddress.description,
              destinationAddress: trek.endAddress.description,
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
    );
  }
}

class LocationPairCard extends StatelessWidget {
  LocationPairCard(
      {required this.originAddress, required this.destinationAddress});
  final String originAddress;
  final String destinationAddress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovementDrawing(height: 73, width: 10),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Location', style: TextStyles.darkMinor),
                Text(originAddress, style: TextStyles.darkNormal),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  height: 1,
                  color: Color(0xffF4F4F6),
                ),
                Text(
                  'Destination Location',
                  style: TextStyles.darkMinor,
                ),
                Text(destinationAddress, style: TextStyles.darkNormal),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6),
                  height: 1,
                  color: Color(0xffF4F4F6),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PlaceSearchBar extends StatefulWidget implements PreferredSizeWidget {
  PlaceSearchBar({
    required this.controller,
  });
  final HomeController controller;

  @override
  _PlaceSearchBarState createState() => _PlaceSearchBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(200);
}

class _PlaceSearchBarState extends State<PlaceSearchBar> {
  late StreamSubscription<SearchBarStatus> sub;
  SearchBarStatus searchBarStatus = SearchBarStatus.normal;
  @override
  void initState() {
    sub = widget.controller.searchBarStatus.listen((status) {
      setState(() {
        searchBarStatus = status;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 36),
        searchBarStatus == SearchBarStatus.expanded
            ? Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom: 6),
                child: MyAppBarNavigation(
                    onBackPressed: widget.controller.collapseSearchBar),
              )
            : Container(),
        Container(
          margin: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: currentSearchWidget(),
        ),
      ],
    );
  }

  Widget currentSearchWidget() {
    switch (searchBarStatus) {
      case SearchBarStatus.expanded:
        return ExpandedSearchBar(
          controller: widget.controller,
        );
      case SearchBarStatus.compressed:
        return CompressedSearchBar(
          controller: widget.controller,
        );
      case SearchBarStatus.normal:
        return NormalSearchBar(
          controller: widget.controller,
        );

      default:
        return NormalSearchBar(
          controller: widget.controller,
        );
    }
  }
}

class CompressedSearchBar extends StatelessWidget {
  CompressedSearchBar({required this.controller});
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: controller.expandSearchBar,
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
                text: controller.origin(),
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
                text: controller.destinationAddress?.toString() != null
                    ? controller.destinationAddress!.description
                    : 'Your Location',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NormalSearchBar extends StatefulWidget {
  NormalSearchBar({
    required this.controller,
  });
  final HomeController controller;

  @override
  _NormalSearchBarState createState() => _NormalSearchBarState();
}

class _NormalSearchBarState extends State<NormalSearchBar> {
  late final TextEditingController searchToTextController;

  @override
  void initState() {
    searchToTextController =
        TextEditingController(text: widget.controller.searchQuery);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
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
              onChanged: widget.controller.search,
              onTap: () {
                widget.controller.setHomeStatus(HomePageStatus.searching);
              },
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
          onTap: widget.controller.expandSearchBar,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(CustomIcons.icons_dark_add, color: Color(0xff454F63)),
          ),
        ),
      ],
    );
  }
}

class ExpandedSearchBar extends StatefulWidget {
  ExpandedSearchBar({required this.controller});
  final HomeController controller;

  @override
  _ExpandedSearchBarState createState() => _ExpandedSearchBarState();
}

class _ExpandedSearchBarState extends State<ExpandedSearchBar> {
  final TextEditingController _searchFromTextController =
      TextEditingController();
  final TextEditingController _searchToTextController = TextEditingController();
  bool _fromEnabled = false;
  bool _toEnabled = true;
//  Address? startAddress;
//  Address? endAddress;
  String? _fromError;
  String? _toError;
  late FocusNode _fromFocus;
  late FocusNode _toFocus;
  @override
  void initState() {
    _updateTextAddress();
    _fromFocus = FocusNode();
    _toFocus = FocusNode();
    _fromFocus.addListener(_suggestFromAddress);
    _toFocus.addListener(_suggestToAddress);
    widget.controller.addListener(() {
      setState(() {
        _updateTextAddress();
      });
    });
    super.initState();
  }

  void _resetForm() {
    _fromEnabled = true;
    _toEnabled = true;
    _searchFromTextController.text = '';
    _searchToTextController.text = '';
    widget.controller.resetAddress();
    setState(() {});
  }

  void _suggestFromAddress() {
    widget.controller.isOriginAddress = true;
    widget.controller.setHomeStatus(HomePageStatus.suggesting);
  }

  void _suggestToAddress() {
    widget.controller.isOriginAddress = false;
    widget.controller.setHomeStatus(HomePageStatus.suggesting);
  }

  void _updateTextAddress() {
    _searchFromTextController.text = widget.controller.origin();
    _searchToTextController.text = widget.controller.destination();
    _toEnabled = widget.controller.destinationAddress == null;
    _fromEnabled = widget.controller.originAddress == null;
    _fromError = _toError = null;
  }

  @override
  void dispose() {
    _searchToTextController.dispose();
    _searchFromTextController.dispose();
    widget.controller.removeListener(_updateTextAddress);
    _fromFocus.dispose();
    _toFocus.dispose();
    super.dispose();
  }

  void _createTrek() {
    if (widget.controller.destinationAddress == null) {
      _toError = 'Select a Valid Destination Address';
      setState(() {});
      return;
    }
    if (widget.controller.originAddress == null) {
      _fromError = 'Select a Valid Origin Address';
      setState(() {});
      return;
    }
    widget.controller.getDirection();
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
                          onChanged: widget.controller.search,
                          focusNode: _fromFocus,
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
                        onTap: _resetForm,
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
                          onChanged: widget.controller.search,
                          enabled: _toEnabled,
                          focusNode: _toFocus,
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
  SearchResults({required this.controller});
  final HomeController controller;
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  final _scrollController = ScrollController();
  late SearchBloc _searchBloc;

  late final StreamSubscription<String> searchSubscription;

  @override
  void initState() {
    // _scrollController.addListener(_onScroll);
    // _searchBloc = BlocProvider.of<SearchBloc>(context);
    _searchBloc = context.read<SearchBloc>(); //Context.read
//    _postBloc.add(ListFetched());
    searchSubscription = widget.controller.searchQueryStream.listen(onSearch);
    super.initState();
  }

  void onSearch(String query) {
    log("widget searching for $query");
    if (query.length > 0) {
      _searchBloc.add(SearchFetched(query: query));
    }
  }

  @override
  void dispose() {
    searchSubscription.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  // void _onScroll() {
  //   if (_isBottom) _searchBloc.add(SearchFetched());
  // }

  // bool get _isBottom {
  //   if (!_scrollController.hasClients) return false;
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.offset;
  //   return currentScroll >= (maxScroll * 0.9);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF7F7FA),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 228,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SEARCH RESULTS',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0x9978849E),
            ),
          ),
          Container(
            height: 180,
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                switch (state.status) {
                  case SearchStatus.failure:
                    return const Center(
                        child: Text('failed to fetch suggestions'));
                  case SearchStatus.success:
                    if (state.models.isEmpty) {
                      return const Center(child: Text('no suggestions'));
                    }
                    return ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return index >= state.models.length
                            ? BottomLoader()
                            : GestureDetector(
                                onTap: () => widget.controller.selectAddress(
                                    state.models[index] as Address),
                                child: SearchResultRow(
                                    state.models[index] as Address),
                              );
                      },
                      itemCount: state.hasReachedMax
                          ? state.models.length
                          : state.models.length + 1,
                      controller: _scrollController,
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
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
                Text(address.description, style: TextStyles.darkNormal),
//                Text('2Km.', style: TextStyles.darkMinor),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: Color(0xff454F63)),
        ],
      ),
    );
  }
}
