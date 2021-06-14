import 'package:flutter/material.dart';
import 'package:wetrek/widgets/widgets.dart';
import 'package:wetrek/constants/text_styles.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Categories'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CategoryItem(),
              CategoryItem(),
              CategoryItem(),
              CategoryItem(),
              CategoryItem(),
              CategoryItem(),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 156,
      margin: EdgeInsets.only(bottom: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Image.asset('images/sushi.jpg',width: double.infinity, fit: BoxFit.cover),
            Container(color: Color(0x29000000)),
            Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(left: 24,bottom: 19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Planes', style: TextStyles.large),
                    Text('56 topics - 2k articles', style: TextStyles.base),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
