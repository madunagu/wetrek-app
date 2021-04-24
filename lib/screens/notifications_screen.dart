import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Notifications',
        rightIcon: Icons.search,
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
              NotificationListItem.random(),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationListItem extends StatelessWidget {
  NotificationListItem({this.imageURL, this.name, this.message, this.isNew});
  final String imageURL;
  final String name;
  final String message;
  final bool isNew;

  factory NotificationListItem.random() {
    return NotificationListItem(
      name: 'Marie Winter',
      imageURL: 'images/avatar3.jpg',
      message: 'If you\'re offered a seat on a rocket ship',
      isNew: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xffF4F4F6)),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageURL,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-112,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(name, style: TextStyles.darkNormal),
                      Text('12min ago',style:TextStyles.darkMinor),
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  message,
                  style: TextStyles.base.copyWith(
                    color: Color(0xff78849E),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
