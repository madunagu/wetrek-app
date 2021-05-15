import 'package:flutter/material.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Trek Path'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('images/dark_map.png'),
              Container(
                width: MediaQuery.of(context).size.width,
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
                      HistoryItem(
                        subTitle: '9:00 (25 mins)',
                        title: 'Shopping',
                        imgSrcs: [
                          'images/avatar1.jpg',
                          'images/avatar2.jpg',
                          'images/avatar3.jpg',
                        ],
                        icon: Icons.save,
                      ),
                      HistoryItem(
                        subTitle: '9:25 (47 mins)',
                        title: 'Meeting at Mile-End',
                        imgSrcs: [
                          'images/avatar1.jpg',
                          'images/avatar2.jpg',
                          'images/avatar3.jpg',
                        ],
                        icon: Icons.save,
                      ),
                      HistoryItem(
                        subTitle: '10:02 (1hr 16 mins)',
                        title: 'Dinner At Sushi Place',
                        imgSrcs: [
                          'images/avatar1.jpg',
                          'images/avatar2.jpg',
                          'images/avatar3.jpg',
                        ],
                        icon: Icons.save,
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

class HistoryItem extends StatelessWidget {
  final IconData icon;
  final subTitle;
  final String title;
  final List<String> imgSrcs;
  const HistoryItem(
      {Key key,
      @required this.icon,
      @required this.subTitle,
      @required this.title,
      @required this.imgSrcs,})
      : super(key: key);

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
                Container(
                  width: 2,
                  height: 100,
                  color: Color(0x20959DAD),
                )
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
              AvatarList(imgSrcs: imgSrcs),
              SizedBox(height: 53),
            ],
          )
        ],
      ),
    );
  }
}
