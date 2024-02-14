import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/blocs/events/search.event.dart';
import 'package:wetrek/blocs/search.bloc.dart';
import 'package:wetrek/blocs/states/search.state.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/controllers/home_controller.dart';
import 'package:wetrek/models/address.dart';
import 'package:wetrek/models/direction.dart';
import 'package:wetrek/models/option.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/presentation/custom_icons.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/location_repository.dart';
import 'package:wetrek/repositories/maps_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/screens/place_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'package:wetrek/widgets/avatar_list.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceDetailsPreview extends StatefulWidget {
  PlaceDetailsPreview({required this.place});
  final Address place;

  @override
  State<PlaceDetailsPreview> createState() => _PlaceDetailsPreviewState();
}

class _PlaceDetailsPreviewState extends State<PlaceDetailsPreview> {
  List<String> images = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    _getImages();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getImages() async {
    try {
      Map<String, dynamic> res =
          await MapsRepository.getPlace(widget.place.reference);
      if (res['result']['photos'] != null &&
          res['result']['photos'].isNotEmpty) {
        List<dynamic> photos = (res['result']['photos'] as List<dynamic>);
        for (var p in photos) {
          images.add(MapsRepository.getPhoto(p['photo_reference']));
        }
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoaded = true;
      });
    }
    setState(() {
      print(images);
      isLoaded = true;
      log(images.toString(), name: 'herald');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 72,
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  //snapshot.hasError     snapshot.connectionState == ConnectionState.waiting
                  flex: 2,
                  child: Container(
                    height: 44,
                    child: images.isEmpty
                        ? isLoaded
                            ? Center(
                                child: Text('Error: no images'),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )
                        : ListView(
                            scrollDirection: Axis.horizontal,
                            children: images
                                .map(
                                  (e) => Image.network(
                                    e,
                                    height: 44,
                                  ),
                                )
                                .toList(),
                          ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.of(context).push(TrekScreen.route(trek));
                      Navigator.of(context)
                          .push(PlaceScreen.route(widget.place));
                    },
                    child: Container(
                      child: MyButton('GO THERE'),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 24),
          RelatedTreks(place: widget.place),
          RelatedTreks(place: widget.place),
          RelatedTreks(place: widget.place),
        ],
      ),
    );
  }
}

class RelatedTreks extends StatefulWidget {
  RelatedTreks({Key? key, required this.place}) : super(key: key);

  Address place;

  @override
  State<RelatedTreks> createState() => _RelatedTreksState();
}

class _RelatedTreksState extends State<RelatedTreks> {
  bool _isOpen = false;
  void _toggleDown() {
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleDown,
      child: Container(
        padding: EdgeInsets.only(
          top: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('images/avatar1.jpg', width: 48, height: 48),
            ),
            SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Mile Trek', style: TextStyles.normal),
              SizedBox(height: 3),
              Text(
                'Abule Ado',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0x86fffffff),
                ),
              ),
              _isOpen
                  ? Container(
                      height: 139,
                      width: MediaQuery.of(context).size.width - 136,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          AvatarList(
                            imgSrcs: [
                              'https://picsum.photos/200',
                              'https://picsum.photos/200',
                            ],
                          ),
                          SizedBox(height: 16),
                          DestinationCard(
                            originAddress: 'Yaba',
                            destinationAddress: 'Abule Ado',
                          ),
                        ],
                      ),
                    )
                  : Container(),
              SizedBox(height: 20),
              Container(
                height: 1,
                width: MediaQuery .of(context).size.width - 136,
                // width: double.infinity,
                color: Color(0x16ffffff),
              )
            ]),
          ],
        ),
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
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> data = {
      "starting_at": _startingAtController.value.text,
      "name": _titleController.value.text,
      "start_address": widget.controller.originAddress!.toJson(),
      "end_address": widget.controller.originAddress!.toJson(),
      "directions": widget.controller.direction!.toJson(),
    };
    print(data);
    try {
      Trek trek = await TrekRepository(
              RepositoryProvider.of<AuthenticationRepository>(context).token!)
          .create(data);
      Navigator.push(context, TrekScreen.route(trek));
    } on Exception catch (e) {
      setState(() {
        isLoading = false;
      });
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
    required this.controller,
    this.color = const Color(0xff353A50),
  });
  final Widget child;
  final Color color;
  final HomeController controller;
  @override
  Widget build(BuildContext context) {
    final Size view = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LocationButton(controller: controller),
        SizedBox(height: 16),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 6),
            width: view.width,
            decoration: BottomSheetDecoration(),
            constraints: BoxConstraints(
              minHeight: 800,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              color: color,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class LocationButton extends StatefulWidget {
  LocationButton({required this.controller});
  final HomeController controller;
  @override
  _LocationButtonState createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  panToLocation() async {
    LocationRepository locationRepository =
        RepositoryProvider.of<LocationRepository>(context);
    Position myPos = await locationRepository.determinePosition();

    //TODO: catch all possible excepitons
    LatLng latLng = LatLng(myPos.latitude, myPos.longitude);
    widget.controller.setLocation(latLng);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: panToLocation,
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
          Icons.my_location,
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
            width: MediaQuery.of(context).size.width - 72,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 72,
                  child: Text(
                    title,
                    style: TextStyles.normal,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 72,
                  child: Text(
                    subTitle,
                    style: TextStyles.minor,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                child != null
                    ? Container(
                        width: MediaQuery.of(context).size.width - 72,
                        child: child!)
                    : Container(),
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
    _searchBloc.add(SearchFetched());
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

  selectPlace(Address place) {
    widget.controller.selectDestinationAddress(place);
    widget.controller.setHomeStatus(HomePageStatus.showing);
  }

  @override
  Widget build(BuildContext context) {
    final String _mapsKey = 'AIzaSyAXYH6jQZSQ6vr6WWgTVpx_Bph2TzEYOY8';
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
                          onTap: () =>
                              selectPlace(state.models[index] as Address),
                          child: PlacedCard(
                            place: state.models[index] as Address,
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
          // SubTripRow(),
          // this is the underline
          Container(),
          // SubTripRow(),
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
  SubTripRow(this.trek);
  final Trek trek;
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
            child: Image.network(trek.picture.small, width: 48, height: 48),
          ),
          SizedBox(width: 16),
          MovementDrawing(height: 43, width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(trek.startAddress.description, style: TextStyles.minor),
            SizedBox(height: 16),
            Text(trek.endAddress.description, style: TextStyles.minor),
          ]),
          Spacer(),
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              // color: Color(0xff353A50),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(trek.name, style: TextStyles.normal),
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
  attendees() {
    if (trek.users != null && trek.users!.isNotEmpty) {
      return trek.users?.first.name;
    }
    return 'Nobody';
  }

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
            // LocationPairCard(
            //   originAddress: trek.startAddress.description,
            //   destinationAddress: trek.endAddress.description,
            // ),
            Container(
              child: Row(
                children: [
                  AvatarList(
                    imgSrcs:
                        trek.users?.map((e) => e.picture.small).toList() ?? [],
                  ),
                  Text(
                    "${attendees()} is attending",
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

class DestinationCard extends StatelessWidget {
  DestinationCard(
      {required this.originAddress, required this.destinationAddress});
  final String originAddress;
  final String destinationAddress;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MovementDrawing(height: 64, width: 10),
        SizedBox(width: 20),
        Expanded(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Start Location', style: TextStyles.darkMinor),
                Text(originAddress, style: TextStyles.normal),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 15),
                //   height: 1,
                //   color: Color(0xffF4F4F6),
                // ),
                SizedBox(height: 28),
                // Text(
                //   'Destination Location',
                //   style: TextStyles.darkMinor,
                // ),
                Text(destinationAddress, style: TextStyles.normal),
                // Container(
                //   margin: EdgeInsets.symmetric(vertical: 6),
                //   height: 1,
                //   color: Color(0xffF4F4F6),
                // ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class PlaceSearchBar extends StatefulWidget {
  PlaceSearchBar({
    required this.controller,
  });
  final HomeController controller;

  @override
  _PlaceSearchBarState createState() => _PlaceSearchBarState();
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
    return Container(
      height: 201,
      width: MediaQuery.of(context).size.width,
      child: Column(
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
      ),
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
                widget.controller.setHomeStatus(HomePageStatus.suggesting);
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
  // final _scrollController = ScrollController();
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
    // _scrollController.dispose();
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
    final Size size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(
        minHeight: 800,
      ),
      color: Color(0xffF7F7FA),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
            height: 280,
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
                    return Column(
                      children: state.models
                          .map((e) => GestureDetector(
                                onTap: () {
                                  widget.controller.selectAddress(e as Address);
                                  SearchBarStatus _searchStatus =
                                      widget.controller.lastSearchStatus;
                                  if (_searchStatus == SearchBarStatus.normal) {
                                    widget.controller
                                        .setHomeStatus(HomePageStatus.showing);
                                  } else {}
                                },
                                child: SearchResultRow(e as Address, size),
                              ))
                          .toList(),
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
  SearchResultRow(this.address, this.size);
  final Address address;
  final Size size;
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
            width: size.width - 56,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.description,
                  style: TextStyles.darkNormal,
                  overflow: TextOverflow.ellipsis,
                ),
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

class MapContainer extends StatefulWidget {
  MapContainer({required this.direction});
  final Direction direction;
  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> with GoogleMapMixin {
  // late StreamSubscription<Location> _locationSub;

  late final String mapStyle;
  late final GoogleMapController _mapController;
  Completer<GoogleMapController> _controller = Completer();

  Map<MarkerId, Marker> _markers = {};
  Map<PolylineId, Polyline> _polyLines = {};

  @override
  void initState() {
    _loadMapStyle();
    super.initState();
  }

  showError(Exception e) {
    if (e is AuthenticationException) {
      showDialog(
        context: context,
        builder: (BuildContext context) => DialogPopup(
          title: 'Error Occurred!',
          body: e.toString(),
          okFunction: () => Navigator.of(context).push(LoginScreen.route()),
          okText: 'LOGOUT',
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopup(
        title: 'Error Occurred!',
        body: e.toString(),
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    log('map created');
    _mapController = await _controller.future;
    placeMarkers();
    _mapController.setMapStyle(mapStyle);
  }

  void _loadMapStyle() {
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapTap(LatLng point) {
//    if (isTouchable) {
//      _showPointDialog(point);
//    }
  }

  void placeMarkers() async {
    if (!_controller.isCompleted) {
      showError(UnknownException(message: 'Google Maps Failure Occurred'));
      return;
    }
    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(
        widget.direction.routes[0].bounds.toLatLng(),
        1,
      ),
    );
    setState(() {
      Polyline poly = getPolyline(widget.direction);
      _polyLines[poly.polylineId] = poly;
      _markers.addAll(getMarkers(poly));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size view = MediaQuery.of(context).size;
    return Container(
      height: view.height - 200,
      width: view.width,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(6.4544837, 3.2519754),
          zoom: 15,
        ),
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        tiltGesturesEnabled: false,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: onMapCreated,
        rotateGesturesEnabled: false,
        markers: Set<Marker>.of(_markers.values),
        polylines: Set<Polyline>.of(_polyLines.values),
        onTap: _onMapTap,
      ),
    );
  }
}
