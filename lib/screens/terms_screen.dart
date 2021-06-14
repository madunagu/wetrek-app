import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets/widgets.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Terms of Use',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'These terms of service constitute an agreement (the “Agreement”) between you and WeTrek. (“WeTrek”, “we,” “us” or “our”) governing your use of the WeTrek application, website.',
                  style: TextStyle(
                    color: Color(0xff78849E),
                  )),
              Text('Accepting Terms of Use', style: TextStyles.darkLarge),
              SizedBox(height: 21),
              Text(
                  'IMPORTANT: BY USING THIS SERVICE, YOU AGREE THAT YOU HAVE READ, UNDERSTOOD, ACCEPTED AND AGREED WITH THESE TERMS AND CONDITIONS. YOU FURTHER AGREE TO THE REPRESENTATIONS MADE BY YOURSELF BELOW. IF YOU DO NOT AGREE TO OR FALL WITHIN THE TERMS OF USE OF THE SERVICE (AS DEFINED BELOW) AND WISH TO DISCONTINUE USING THE SERVICE, PLEASE DO NOT CONTINUE USING THIS APPLICATION OR SERVICE.',
                  style: TextStyles.darkNormal),
              SizedBox(height: 23),
              Text(
                'The terms and conditions stated herein (collectively, the “Terms of Use” or this “Agreement”) constitute a legal agreement between you and WeTrek and its subsidiaries and affiliates (“WeTrek”). In order to use the Service (each as defined below) you must agree to the Terms of Use that are set out below. By using the mobile applications and websites supplied to you by WeTrek (the  “Application”), and downloading, installing or using any associated software supplied by WeTrek (the “Software”) which overall purpose is to enable persons seeking tourism/trekking services to certain destinations to be matched together, you hereby expressly acknowledge and agree to be bound by the Terms of Use, and any future amendments and additions to this Terms of Use as published from time to time through the Application.',
                style: TextStyle(
                  color: Color(0xff78849E),
                ),
              ),
              SizedBox(height: 16),
              Text('Privacy', style: TextStyles.darkNormal),
              SizedBox(height: 21),
              Text(
                'When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ',
                style: TextStyle(
                  color: Color(0xff78849E),
                ),
              ),
              SizedBox(height: 21),
              MyButton('CONTINUE & AGREE', color: Color(0xff3ACCE1)),
            ],
          ),
        ),
      ),
    );
  }
}
