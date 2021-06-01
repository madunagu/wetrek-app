import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/widgets.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.user});
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1000,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              height: 385,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'images/avatar1.jpg',
                fit: BoxFit.cover,
                height: 385,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              top: 61,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 43,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 301,
              left: 0,
              width: MediaQuery.of(context).size.width,
              height: 700,
              child: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 38),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(80)),
                  color: Color(0xFFF1F0F2),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 32,
                                    color: Color(0xFF454f63),
                                  ),
                                ),
                                Text(
                                  'San Fransico CA, 20 years',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff78849E)),
                                ),
                              ],
                            ),
                          ),
                          FollowButton(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ChatScreen(title: user.name),
                                    ),
                                  );
                                },
                                child: Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Icon(
                                        Icons.chat,
                                        color: Color(0xff9599b3),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        'Chat',
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff78849e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Color(0xff9599b3),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff78849e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Color(0xff9599b3),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff78849e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0x23998fa2),
                            height: 1,
                            margin: EdgeInsets.symmetric(vertical: 32),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Color(0xff9599b3),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff78849e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Color(0xff9599b3),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff78849e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Icon(
                                      Icons.chat,
                                      color: Color(0xff9599b3),
                                    ),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      'Chat',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Color(0xff78849e),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                        color: Color(0xFFFFFFFF),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Image.asset(
                                  'images/avatar1.jpg',
                                  height: 36,
                                  width: 36,
                                ),
                              ),
                            ],
                          ),
                          Column(),
                          Icon(Icons.keyboard_arrow_down),
                        ],
                      ),
                    ),
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

class UserActionsBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0xff455B63),
            offset: Offset(0, 16),
            blurRadius: 16,
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Color(0x23998fa2),
            height: 1,
            margin: EdgeInsets.symmetric(vertical: 32),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Icon(
                      Icons.chat,
                      color: Color(0xff9599b3),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xff78849e),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserNameAndFollow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maria Snow',
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xff454F63),
                      fontWeight: FontWeight.w500,
                      height: 44 / 32,
                    ),
                  ),
                  Text(
                    'San Francisco, CA 20 years',
                    style: TextStyles.darkNormal.copyWith(
                      color: Color(0xff78849E),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(flex: 1, child: MyButton('FOLLOW'))
        ],
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyButton('FOLLOW');
  }
}
