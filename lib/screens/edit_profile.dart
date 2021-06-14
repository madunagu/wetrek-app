import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets/widgets.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profile'),
      body: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/avatar1.jpg',
                width: 128,
                height: 128,
              ),
            ),
            SizedBox(height: 20),
            Text('Maria Snow', style: TextStyles.darkLarge),
            Text('San Fransico CA',style: TextStyles.darkNormal),
            // Nick name or alias should be part of the profile
            SizedBox(height: 23),
            MyInput(),
          ],
        ),
      ),
    );
  }
}
