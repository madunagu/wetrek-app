import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets/widgets.dart';

class StatisticsScreen extends StatelessWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => StatisticsScreen(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Statistics'),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailCard(),
              DetailCard(),
              SizedBox(height: 22),
              Text('FAVORITE PLACES', style: TextStyles.darkMinor),
              SizedBox(height: 15),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    OverlayPlacedCard(
                      title: 'Sushi Place',
                      subTitle: '4.6',
                    ),
                    OverlayPlacedCard(
                      title: 'Sushi Place',
                      subTitle: '4.6',
                    ),
                    OverlayPlacedCard(
                      title: 'Sushi Place',
                      subTitle: '4.6',
                    ),
                    OverlayPlacedCard(
                      title: 'Sushi Place',
                      subTitle: '4.6',
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      margin: EdgeInsets.only(bottom: 16),
      height: 174,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color(0xff5773FF),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Text(
                '95',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: -70 / 64,
                ),
              ),
              SizedBox(width: 13),
              Text(
                'km',
                style: TextStyle(
                  color: Color(0x3dffffff),
                  fontSize: 48,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Container(
            color: Color(0xff5773FF),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Time',
                  style: TextStyles.base,
                ),
                Text(
                  'Set Goal',
                  style: TextStyles.base.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
