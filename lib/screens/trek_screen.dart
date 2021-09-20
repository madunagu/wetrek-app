import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/chat_screen.dart';
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

class _TrekScreenState extends State<TrekScreen> {
  late Trek trek;
  bool isJoining = false;
  late bool isAttending= false;
  @override
  void initState() {
    trek = widget.trek;
    getTrek();
    super.initState();
  }

  void getTrek() async {
    String token =
        RepositoryProvider.of<AuthenticationRepository>(context).token!;
    User user = BlocProvider.of<AuthenticationBloc>(context).state.user!;
    trek = await TrekRepository(token).get(widget.trek.id);
    //TODO: edit the strictness of the contains check due to differences in contained variables
    isAttending = trek.users?.contains(user) ?? false;
  }

  _joinTrek() async {
    isJoining = true;
    String token =
        RepositoryProvider.of<AuthenticationRepository>(context).token!;
    isAttending = await TrekRepository(token).join(trek.id);
  }

  Color _joinColor() {
    if (isJoining || isAttending) return Colors.grey;
    return WeTrekColors.blue1;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: MyAppBar(title: 'Trek Path'),
      floatingActionButton: Container(
          width: 52,
          height: 52,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: WeTrekColors.blue3,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.share,
            color: Colors.white,
          )),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                trek.picture.large,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(trek.name, style: TextStyles.darkLarge),
                      SizedBox(height: 16),
                      Text(
                        widget.trek.name,
                        style: TextStyles.darkMinor,
                      ),
                      SizedBox(height: 16),
                      TrekItem(
                        subTitle: "${trek.usersCount} Trekkers",
                        title: 'Trekkers',
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, UsersScreen.route());
                          },
                          child: AvatarList(
                            imgSrcs: trek.users
                                    ?.map((e) => e.picture.small)
                                    .toList() ??
                                [],
                          ),
                        ),
                        icon: Icons.people_outline,
                      ),
                      TrekItem(
                        subTitle: 'group messages',
                        title: 'Chats',
                        icon: Icons.chat_bubble_outline,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              ChatScreen.route(widget.trek),
                            );
                          },
                          child: AvatarList(
                            imgSrcs: trek.users
                                    ?.map((e) => e.picture.small)
                                    .toList() ??
                                [],
                          ),
                        ),
                      ),
                      TrekItem(
                        subTitle: trek.direction.routes.first.summary,
                        title: 'Direction Details',
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                PathScreen.route(widget.trek.direction));
                          },
                          child: Container(
                            height: 44,
                            width: size.width - 136,
                            child: Text(
                              "Start At ${trek.startAddress.description} and move on to ${trek.endAddress.description}",
                              style: TextStyles.darkMinor,
                            ),
                          ),
                        ),
                        icon: Icons.directions_walk,
                      ),
                      TrekItem(
                        subTitle: "${trek.pictures?.length} pictures",
                        title: 'Pictures',
                        child: Container(
                          height: 44,
                          width: size.width - 136,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: trek.pictures
                                    ?.map((e) =>
                                        Image.network(e.small, height: 44))
                                    .toList() ??
                                [],
                          ),
                        ),
                        icon: Icons.save,
                      ),
                      SizedBox(height: 16),
//                      for(var step in )

                      MyButton(
                        'GO THERE',
                        onTap: _joinTrek,
                        color: _joinColor(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TrekItem extends StatelessWidget {
  final IconData icon;
  final subTitle;
  final String title;
  final Widget? child;
  const TrekItem({
    Key? key,
    required this.icon,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subTitle,
                style: TextStyles.darkMinor,
              ),
              Text(
                title,
                style: TextStyles.darkNormal,
              ),
              SizedBox(height: 11),
              child ?? Container(),
              SizedBox(height: 26),
            ],
          )
        ],
      ),
    );
  }
}
