import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/trek.dart';
import 'package:wetrek/repositories/trek_repository.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/avatar_list.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class TripsScreen extends StatefulWidget {
  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];

//  RefreshController _refreshController =
//      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
//    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
//    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Trips',
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xfff4f4f6)))),
            child: TabBar(
              indicator: BlueDashGradientDecoration(height: 6),
              labelPadding: EdgeInsets.all(0),
              tabs: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xfff4f4f6)),
                    ),
                  ),
                  child: Tab(
                      child: Text(
                    'UPCOMING',
                    style: TextStyles.tab,
                  )),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(color: Color(0xfff4f4f6)),
                    ),
                  ),
                  child: Tab(
                      child: Text(
                    'HISTORY',
                    style: TextStyles.tab,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xffF7F7FA),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Color(0xffF7F7FA),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                    SingleTrek(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleTrek extends StatelessWidget {
  const SingleTrek({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JAN 10 - 12:30 PM',
          style: TextStyles.darkMinor.copyWith(
            color: Color(0x9278849E),
          ),
        ),
        SizedBox(height: 12),
        LocationPairCard(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrekScreen(trek: TrekRepository.dummy()),
              ),
            );
          },
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
