import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/dotted_tab_bar.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/car.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          DottedTabBar(),
          Positioned(
            bottom: 0,
            child: Container(
              child: Column(
                children: [
                  Text('Welcome To WeTrek',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 52,
                          fontWeight: FontWeight.w500)),
                  Text(
                      'The best way to navigate your world and discover new places. Let\'s get started!',
                      style: TextStyles.base),
                  SizedBox(height: 38),
                  Text('CONTINUE WITH',
                      style: TextStyles.minor.copyWith(color: Colors.white)),
                  MyButton('GMAIL'),
                  SizedBox(height: 12),
                  MyButton('FACEBOOK'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
