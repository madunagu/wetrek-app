import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/mixins/popup_mixin.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/where.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/screens/full_screen_image.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/screens/path_screen.dart';
import 'package:wetrek/screens/users_screen.dart';
import 'package:wetrek/widgets/map_widgets.dart';
import 'package:wetrek/widgets/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';

class TrekScreen extends StatefulWidget {
  final Trek trek;
  TrekScreen({required this.trek});

  static route(Trek trek) {
    return MaterialPageRoute(
      builder: (context) => TrekScreen(
        trek: trek,
      ),
    );
  }

  @override
  _TrekScreenState createState() => _TrekScreenState();
}

class _TrekScreenState extends State<TrekScreen> with MyPopupMixin {
  bool isJoining = true;
  late bool isAttending = false;
  late Trek trek;
  late final String token;

  @override
  void initState() {
    trek = widget.trek;
    token = RepositoryProvider.of<AuthenticationRepository>(context).token!;
    getTrek();
    super.initState();
  }

  getTrek() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => LoadingPopup(),
    );
    trek = await TrekRepository(token).get(widget.trek.id);

    setState(() {
      isJoining = false;
      isAttending = trek.isAttending ?? false;
    });
    Navigator.pop(context);
  }

  _joinTrek() async {
    showLoader();
    bool _isAttending = await TrekRepository(token).join(widget.trek.id);
    log(_isAttending.toString());
    setState(() {
      isJoining = false;
      isAttending = _isAttending;
    });
    hideLoader();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: size.width,
              child: MapContainer(direction: widget.trek.direction!)),
          Positioned(
            top: 56,
            child: Container(
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: MyAppBarNavigation(
                fontColor: Colors.white,
                rightIcon: Icons.share,
                onPressed: () {
                  // Navigator.push(context, EditProfile.route());
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
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text(trek.name, style: TextStyles.darkLarge),
                        SizedBox(height: 16),
                        Text(
                          trek.name,
                          style: TextStyles.darkMinor,
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              UsersScreen.route([
                                Where(
                                  column: 'trek',
                                  val: trek.id.toString(),
                                ),
                              ]),
                            );
                          },
                          child: TrekItem(
                            size: size,
                            subTitle: "${trek.usersCount ?? 0} Trekkers",
                            title: 'Trekkers',
                            icon: Icons.people_outline,
                            child: AvatarList(
                              imgSrcs: trek.users
                                      ?.map((e) => e.picture.small)
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              ChatScreen.route(widget.trek),
                            );
                          },
                          child: TrekItem(
                            size: size,
                            subTitle: 'Group Messages',
                            title: 'Chats',
                            icon: Icons.chat_bubble_outline,
                            child: AvatarList(
                              imgSrcs: trek.users
                                      ?.map((e) => e.picture.small)
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                PathScreen.route(widget.trek.direction));
                          },
                          child: TrekItem(
                            size: size,
                            subTitle:
                                widget.trek.direction!.routes.first.summary,
                            title: 'Direction Details',
                            icon: Icons.directions_walk,
                            child: Container(
                              height: 44,
                              width: size.width - 136,
                              child: Row(
                                children: [
                                  MovementDrawingForDestination(2, width: 20),
                                  Container(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Start At ${widget.trek.startAddress.description}",
                                          style: TextStyles.darkMinor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "To ${widget.trek.endAddress.description}",
                                          style: TextStyles.darkMinor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TrekItem(
                          size: size,
                          subTitle:
                              "${widget.trek.pictures?.length ?? 1} pictures",
                          title: 'Pictures',
                          child: Container(
                            height: 44,
                            width: size.width - 136,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: (widget.trek.pictures ??
                                        [widget.trek.picture])
                                    .map(
                                      (e) => GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                FullScreenImage.route(e.full));
                                          },
                                          child: Image.network(e.small,
                                              height: 44)),
                                    )
                                    .toList()),
                          ),
                          icon: Icons.save,
                        ),
                        SizedBox(height: 16),
//                      for(var step in )

                        isJoining
                            ? CircularProgressIndicator()
                            : MyButton(
                                isAttending ? 'LEAVE TREK' : 'JOIN TREK',
                                onTap: _joinTrek,
                                color: isAttending
                                    ? Colors.grey
                                    : WeTrekColors.blue1,
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

class TrekItem extends StatelessWidget {
  final IconData icon;
  final subTitle;
  final String title;
  final Widget? child;
  final Size size;
  const TrekItem({
    Key? key,
    required this.icon,
    required this.size,
    required this.subTitle,
    required this.title,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: WeTrekColors.blue4,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
//                Container(
//                  width: 2,
//                  height: 100,
//                  color: Color(0x20959DAD),
//                )
              ],
            ),
          ),
          SizedBox(width: 40),
          Container(
            width: size.width - 136,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.darkMinor,
                ),
                Text(
                  title,
                  style: TextStyles.darkNormal,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 11),
                child ?? Container(),
                SizedBox(height: 26),
              ],
            ),
          )
        ],
      ),
    );
  }
}
