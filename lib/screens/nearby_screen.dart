import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets/widgets.dart';

class NearbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(title: 'Nearby',color: Color(0xff2A2E43),fontColor: Colors.white),
      body: Container(
        color: Color(0xff2A2E43),
        padding: EdgeInsets.only(left: 16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sushi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 27 / 20,
              ),
            ),
            SizedBox(height: 13),
            Container(
              height: 172,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                ],
              ),
            ),
            SizedBox(height: 34),
            Text(
              'Sushi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 27 / 20,
              ),
            ),
            SizedBox(height: 13),
            Container(
              height: 172,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                ],
              ),
            ),
            SizedBox(height: 34),
            Text(
              'Sushi',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 27 / 20,
              ),
            ),
            SizedBox(height: 13),
            Container(
              height: 172,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                  // PlacedCard(title: 'Sushi Place', subTitle: '2.5stars'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
