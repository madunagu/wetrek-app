import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/widgets.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Messages',
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
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
              MessageListItem.random(),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageListItem extends StatelessWidget {
  MessageListItem({this.imageURL, this.name, this.message, this.isNew});
  final String imageURL;
  final String name;
  final String message;
  final bool isNew;

  factory MessageListItem.random() {
    return MessageListItem(
      name: 'Marie Winter',
      imageURL: 'images/avatar3.jpg',
      message: 'If you\'re offered a seat on a rocket ship',
      isNew: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 22),
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
              width: 62,
              height: 62,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width-126,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(name, style: TextStyles.darkNormal),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffff4f9a)
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 7),
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
