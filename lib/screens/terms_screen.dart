import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Terms',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Article 1', style: TextStyles.darkLarge),
              SizedBox(height: 21),
              Text('Who May Use the Services', style: TextStyles.darkNormal),
              SizedBox(height: 23),
              Text(
                'When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us. ',
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
