import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets/widgets.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Payments'),
      body: Container(
        child: Column(
          children: [
            MyInput(),
            MyInput(),
            MyInput(),
          ],
        ),
      ),
    );
  }
}

