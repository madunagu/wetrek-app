import 'package:flutter/material.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/trek.dart';
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
          child: Icon(Icons.share,color: Colors.white,)),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'images/dark_map.png',
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
                      Text('ABULE ADO TREK', style: TextStyles.darkLarge),
                      SizedBox(height: 16),
                      Text(
                        'The restaurant has an extensive selection of fresh fish flown in daily from the Sea of Japan as well as both the Atlantic and Pacific oceans.',
                        style: TextStyles.darkMinor,
                      ),
                      SizedBox(height: 16),
                      TrekItem(
                        subTitle: '15 treks',
                        title: 'Trekkers',
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, UsersScreen.route());
                          },
                          child: AvatarList(
                            imgSrcs: [
                              'images/avatar1.jpg',
                              'images/avatar2.jpg',
                              'images/avatar3.jpg',
                            ],
                          ),
                        ),
                        icon: Icons.people_outline,
                      ),
                      TrekItem(
                        subTitle: '45 messages',
                        title: 'Chats',
                        icon: Icons.chat_bubble_outline,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, ChatScreen.route());
                          },
                          child: AvatarList(
                            imgSrcs: [
                              'images/avatar1.jpg',
                              'images/avatar2.jpg',
                              'images/avatar3.jpg',
                            ],
                          ),
                        ),
                      ),
                      TrekItem(
                        subTitle: '5 pictures',
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
                              'Start At Address and move on to Address',
                              style: TextStyles.darkMinor,
                            ),
                          ),
                        ),
                        icon: Icons.directions_walk,
                      ),
                      TrekItem(
                        subTitle: '5 pictures',
                        title: 'Pictures',
                        child: Container(
                          height: 44,
                          width: size.width - 136,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Image.asset('images/sushi.jpg', height: 44),
                              Image.asset('images/museum.jpg', height: 44),
                              Image.asset('images/ice_cream.jpg', height: 44),
                            ],
                          ),
                        ),
                        icon: Icons.save,
                      ),
                      SizedBox(height: 16),
//                      for(var step in )

                      MyButton('GO THERE'),
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
