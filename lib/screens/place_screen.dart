import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';
import 'package:wetrek/widgets/map_widgets.dart';

class PlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 24),
          color: Color(0xff2A2E43),
          child: Column(
            children: [
              Text(
                'Description',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 15),
              Text(
                  'The restaurant has an extensive selection of fresh fish flown in daily from the Sea of Japan as well as both the Atlantic and Pacific oceans.',
                  style: TextStyles.base),
              SizedBox(height: 41),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyIconButton(),
                    SizedBox(width: 16),
                    Text(
                      '+1 (828) 832-4256',
                      style: TextStyles.normal,
                    )
                  ],
                ),
              ),
              SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('images/map.jpg', height: 128),
              ),
              SizedBox(height: 30),
              MyButton('GO THERE'),
            ],
          ),
        ),
      ),
    );
  }
}
