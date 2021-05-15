import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/controllers/search_bar.controller.dart';
import 'package:wetrek/models/option.dart';
import 'package:wetrek/presentation/custom_icons.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
import 'package:wetrek/widgets/place/search_map_place.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PlaceDetailsPreview extends StatelessWidget {
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

class MapSheet extends StatelessWidget {
  MapSheet({this.child, this.topBorder = const GradientLine()});
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
    Key key,
    this.child,
    this.title = 'Nearby',
    this.subTitle = 'Foods, drinks, places',
    this.rightContent,
  }) : super(key: key);
  final Widget child;
  final Widget rightContent;
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
                if (child != null) child,
              ],
            ),
          ),
          if (rightContent != null) Spacer(),
          if (rightContent != null) rightContent,
        ],
      ),
    );
  }
}

class PlacesNearby extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          PlacedCard(
            title: 'Sushi Place',
            subTitle: '4 stars',
            active: true,
          ),
          PlacedCard(
            title: 'Sushi Place',
            subTitle: '4 stars',
          ),
          PlacedCard(
            title: 'Sushi Place',
            subTitle: '4 stars',
          ),
        ],
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
  const MyIconButton({Key key, this.icon = Icons.phone}) : super(key: key);
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
    @required this.title,
    this.subTitle,
    @required this.value,
    @required this.controller,
  });
  final Widget title;
  final String subTitle;
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
              Text(subTitle, style: TextStyles.minor),
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
    Key key,
    @required this.children,
  }) : super(key: key);
  final List<Option> children;

  @override
  _SelectCardGroupState createState() => _SelectCardGroupState();
}

class _SelectCardGroupState extends State<SelectCardGroup> {
  TextEditingController _controller;

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
  LocationPairCard({this.onTap});
  final Function onTap;
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
                    Text('pickup Location', style: TextStyles.darkMinor),
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
                          Text('Ekene is attending',
                              style: TextStyles.darkMinor),
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
    this.onTap,
  });
  final Function onTap;

  @override
  _PlaceSearchBarState createState() => _PlaceSearchBarState();
}

class _PlaceSearchBarState extends State<PlaceSearchBar> {
  bool isDouble = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: isDouble
          ? DoubleSearchBar(
              onCancel: () {
                setState(() {
                  isDouble = false;
                });
              },
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDouble = true;
                    });
                  },
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
                    padding:
                        const EdgeInsets.only(top: 6.0, left: 16, bottom: 6),
                    child: TextField(
                      onTap: widget.onTap,
                      style: TextStyles.darkNormal,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Where To?',
                        hintStyle: TextStyles.darkNormal
                            .copyWith(color: Color(0xff78849E)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(CustomIcons.icons_dark_close,
                      color: Color(0xff454F63)),
                ),
              ],
            ),
    );
  }
}

class CollapsingSearchBar extends StatefulWidget {
  CollapsingSearchBar({this.controller});
  final SearchBarController controller;

  @override
  _CollapsingSearchBarState createState() => _CollapsingSearchBarState();
}

class _CollapsingSearchBarState extends State<CollapsingSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 133,
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
                  TextField(
                    style: TextStyles.darkNormal,
                    decoration: InputDecoration(
                      labelText: 'From',
                      labelStyle: TextStyles.darkMinor,
                      border: InputBorder.none,
                    ),
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
                          decoration: InputDecoration(
                            labelText: 'To',
                            labelStyle: TextStyles.darkMinor,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onCancel,
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF7F7FA),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
          SearchResultRow(),
          SearchResultRow(),
          SearchResultRow(),
          SearchResultRow(),
        ],
      ),
    );
  }
}

class SearchResultRow extends StatelessWidget {
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
                Text('View All Sushi Restaurants',
                    style: TextStyles.darkNormal),
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
