import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Payments'),
      body: Column(
        children: [
          MyInput(),
          MyInput(),
          MyInput(),
        ],
      ),
    );
  }
}

class MyInput extends StatelessWidget {
  MyInput();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Color(0xff455B63),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: TextField(
        style: TextStyles.input,
      ),
    );
  }
}
