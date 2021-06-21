import 'package:flutter/material.dart';
import 'package:wetrek/widgets/widgets.dart';

class CreateTrekForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MyInput(),
          MyInput(),
          MyInput(),
        ],
      ),
    );
  }
}
