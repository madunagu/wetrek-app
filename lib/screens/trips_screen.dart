import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class TripsScreen extends StatelessWidget {
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
      body: SingleChildScrollView(
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
              Text(
                'JAN 10 - 12:30 PM',
                style: TextStyles.darkMinor.copyWith(
                  color: Color(0x9278849E),
                ),
              ),
              SizedBox(height: 12),
              LocationPairCard(),
              SizedBox(height: 24),
              Text(
                'JAN 10 - 12:30 PM',
                style: TextStyles.darkMinor.copyWith(
                  color: Color(0x9278849E),
                ),
              ),
              SizedBox(height: 12),
              LocationPairCard(),
              SizedBox(height: 24),
              Text(
                'JAN 10 - 12:30 PM',
                style: TextStyles.darkMinor.copyWith(
                  color: Color(0x9278849E),
                ),
              ),
              SizedBox(height: 12),
              LocationPairCard(),
              SizedBox(height: 24),
              Text(
                'JAN 10 - 12:30 PM',
                style: TextStyles.darkMinor.copyWith(
                  color: Color(0x9278849E),
                ),
              ),
              SizedBox(height: 12),
              LocationPairCard(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
