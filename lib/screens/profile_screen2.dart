import 'package:flutter/material.dart';
import 'package:wetrek/models/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:MyAppBarNavigation(),
      body: Column(
        children: [
          SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              user.picture.medium,
              width: 128,
              height: 128,
            ),
          ),
          SizedBox(height: 20),
          Text(
           user.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xff454F63),
            ),
          ),
          Text(
            '15 regular',
            style: TextStyle(color: Color(0xff78849E), fontSize: 16),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Color(0x14455B63))],
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '125',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff454F63),
                          ),
                        ),
                        Text(
                          'FOLLOWERS',
                          style:
                              TextStyle(color: Color(0xff78849E), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '125',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff454F63),
                          ),
                        ),
                        Text(
                          'FOLLOWERS',
                          style:
                              TextStyle(color: Color(0xff78849E), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                          '125',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff454F63),
                          ),
                        ),
                        Text(
                          'FOLLOWERS',
                          style:
                              TextStyle(color: Color(0xff78849E), fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
