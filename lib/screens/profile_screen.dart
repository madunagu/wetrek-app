import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/models/where.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/screens/chats_screen.dart';
import 'package:wetrek/screens/edit_profile.dart';
import 'package:wetrek/screens/notifications_screen.dart';
import 'package:wetrek/screens/settings_screen.dart';
import 'package:wetrek/screens/statistics_screen.dart';
import 'package:wetrek/screens/users_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({required this.user});
  final User user;
  static MaterialPageRoute route(User user) {
    return MaterialPageRoute(
      builder: (context) => ProfileScreen(user: user),
    );
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final bool isMyProfile;
  late final User myself;
  chatTapped() {
    if (isMyProfile) {
      Navigator.push(context, ChatsScreen.route());
    } else {
      Navigator.push(context, ChatScreen.route(widget.user));
    }
  }

  String readableAddress() {
    if (isMyProfile) {
      return 'My Location';
    }
    Location userLocation = widget.user.locations.isEmpty
        ? Location(lat: 0, lng: 0)
        : widget.user.locations.last;
    Location myLocation = myself.locations.isEmpty
        ? Location(lat: 0, lng: 0)
        : myself.locations.last;

    const R = 6371e3; // metres
    double fi1 = myLocation.lat * math.pi / 180; // φ, λ in radians
    double fi2 = userLocation.lat * math.pi / 180;
    double dLat = (userLocation.lat - myLocation.lat) * math.pi / 180;
    double dLon = (userLocation.lng - myLocation.lng) * math.pi / 180;

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(fi1) * math.cos(fi2) * math.sin(dLon / 2) * math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    int distance = (R * c / 100).round(); // in Kilometres

    return "${distance}Km away";
  }

  locationTapped() {}

  statisticsTapped() {
    Navigator.push(context, StatisticsScreen.route());
  }

  @override
  void initState() {
    myself = BlocProvider.of<AuthenticationBloc>(context).state.user!;
    isMyProfile = myself.id == widget.user.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Image.network(widget.user.picture.large,
              fit: BoxFit.cover, height: 400),
          Container(
            height: 400,
            color: Colors.black26,
          ),
          Positioned(
            top: 56,
            child: Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: MyAppBarNavigation(
                fontColor: Colors.white,
                rightIcon: Icons.edit,
                onPressed: () {
                  Navigator.push(context, EditProfile.route());
                },
              ),
            ),
          ),
          DraggableScrollableSheet(
              initialChildSize: 0.5,
              minChildSize: 0.5,
              builder: (BuildContext context, ScrollController controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 38),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      widget.user.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 32,
                                        color: Color(0xFF454f63),
                                      ),
                                    ),
                                    Text(
                                      readableAddress(),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff78849E),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 32),
                              isMyProfile
                                  ? Container()
                                  : FollowButton(widget.user),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            color: Color(0xFFFFFFFF),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x14455B63),
                                offset: Offset(0, 4),
                                blurRadius: 16,
                              )
                            ],
                          ),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  ProfileButton(
                                    onTap: chatTapped,
                                    icon: Icons.chat_bubble_outline,
                                    color: Color(0xff3ACCE1),
                                    label: 'Chat',
                                  ),
                                  ProfileButton(
                                    onTap: statisticsTapped,
                                    icon: Icons.dock_outlined,
                                    color: Color(0xff3497FD),
                                    label: 'Statistics',
                                  ),
                                  ProfileButton(
                                    onTap: locationTapped,
                                    icon: Icons.location_on,
                                    color: Color(0xff665EFF),
                                    label: 'Location',
                                  ),
                                ],
                              ),
                              Container(
                                color: Color(0x23998fa2),
                                height: 1,
                                margin: EdgeInsets.symmetric(vertical: 32),
                              ),
                              isMyProfile
                                  ? Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        ProfileButton(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              UsersScreen.route([
                                                Where(
                                                  column: 'following',
                                                  val: "${widget.user.id}",
                                                ),
                                              ]),
                                            );
                                          },
                                          icon: Icons.people_outline,
                                          color: Color(0xffC840E9),
                                          label: 'Friends',
                                        ),
                                        ProfileButton(
                                          onTap: () {
                                            Navigator.push(context,
                                                SettingsScreen.route());
                                          },
                                          icon: Icons.settings,
                                          color: Color(0xffFF4F9A),
                                          label: 'Settings',
                                        ),
                                        ProfileButton(
                                          onTap: () {
                                            Navigator.push(context,
                                                NotificationScreen.route());
                                          },
                                          icon: Icons.chat,
                                          color: Color(0xffFF9057),
                                          label: 'Notifications',
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 32,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(40),
                            ),
                            color: Color(0xFFFFFFFF),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Image.asset(
                                      'images/avatar1.jpg',
                                      height: 36,
                                      width: 36,
                                    ),
                                  ),
                                ],
                              ),
                              Column(),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class FollowersCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x14455B63))],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    '125',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff454F63),
                    ),
                  ),
                  Text(
                    'FOLLOWERS',
                    style: TextStyle(color: Color(0xff78849E), fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    '125',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff454F63),
                    ),
                  ),
                  Text(
                    'FOLLOWERS',
                    style: TextStyle(color: Color(0xff78849E), fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    '125',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff454F63),
                    ),
                  ),
                  Text(
                    'FOLLOWERS',
                    style: TextStyle(color: Color(0xff78849E), fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final Function() onTap;
  ProfileButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(
                icon,
                color: color,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xff78849e),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
