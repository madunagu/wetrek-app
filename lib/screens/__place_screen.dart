
import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/screens/users_screen.dart';
import '../widgets/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class PlaceScreen extends StatelessWidget {
  static route(Trek trek) {
    return MaterialPageRoute(
      builder: (context) => PlaceScreen(
        trek: trek,
      ),
    );
  }

  PlaceScreen({required this.trek});
  final Trek trek;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 340.0,
              floating: false,
              actions: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
                ),
              ],
              pinned: true,
              backgroundColor: Color(0xff2a2e43),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trek.name,
                        style: TextStyles.title.copyWith(color: Colors.white),
                      ),
                      Row(
                        children: [
                          ReviewBar(max: 5, num: 4),
                          SizedBox(width: 12),
                          Text('24 Reviews', style: TextStyles.base),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: Container(
                  height: 100,
                ),
                background: Container(
                  child: Stack(
                    children: [
                      Image.asset(
                        "images/dark_map.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0x002A2E43),
                              Color(0x8408090D),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          color: Color(0xff2A2E43),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'The restaurant has an extensive selection of fresh fish flown in daily from the Sea of Japan as well as both the Atlantic and Pacific oceans.',
                  style: TextStyles.base,
                ),
                SizedBox(height: 41),
                Text('Time', style: TextStyles.base),
                SizedBox(height: 12),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyIconButton(icon: Icons.access_time),
                      SizedBox(width: 16),
                      Text(
                        "${trek.startingAt.hour}:${trek.startingAt.minute}",
                        style: TextStyles.normal,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Phone', style: TextStyles.base),
                SizedBox(height: 12),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyIconButton(),
                      SizedBox(width: 16),
                      Text(
                        '+1 (828) 832-4256',
                        style: TextStyles.normal,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Attending', style: TextStyles.base),
                SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.push(context, UsersScreen.route([]));
                  },
                  child: Row(
                    children: [
                      AvatarList(imgSrcs: [
                        'images/avatar1.jpg',
                        'images/avatar2.jpg',
                        'images/avatar3.jpg',
                      ]),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Path Details', style: TextStyles.base),
                SizedBox(height: 12),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'images/dark_map.png',
                        height: 128,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                MyButton('GO THERE'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
