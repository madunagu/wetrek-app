import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/screens/payment_screen.dart';
import 'package:wetrek/widgets.dart';

class PhoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xff2A2E43),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
            child: Column(
              children: [
                Text(
                  'Enter your phone number',
                  style: TextStyles.title.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 38),
                MyInput(),
                SizedBox(height: 56),
                MyButton('NEXT STEP'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
