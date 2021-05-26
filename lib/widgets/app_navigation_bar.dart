import 'package:flutter/material.dart';
import 'package:wetrek/widgets.dart';

class AppNavigationDrawer extends StatefulWidget {
  @override
  _AppNavigationDrawerState createState() => _AppNavigationDrawerState();
}

class _AppNavigationDrawerState extends State<AppNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: 325,
      height: size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: [
                Image.asset(
                  'images/photo.png',
                  width: 325,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 250,
                  width: 325,
                  color: Color(0x2e2A2E43),
                ),
                Container(
                  padding: EdgeInsets.only(top: 60, left: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'images/avatar2.jpg',
                          width: 64,
                          height: 64,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Ekene Madunagu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 32 / 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        '@ekenemadunagu',
                        style: TextStyle(
                          color: Color(0x8fffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GradientLine(height: 8),
          Container(
            padding: EdgeInsets.only(top: 40, left: 27),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerLink(
                  title: 'Home',
                ),
                DrawerLink(
                  title: 'Videos',
                ),
                DrawerLink(
                  title: 'Devotionals',
                ),
                DrawerLink(
                  title: 'Events',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerLink extends StatelessWidget {
  final String title;
  final bool active;
  final VoidCallback? onTap;
  final IconData icon;
  DrawerLink({
    required this.title,
    this.active = false,
    this.icon = Icons.home,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: active
              ? BoxDecoration(
                  color: Color(0xff8A56AC),
                  borderRadius: BorderRadius.circular(30),
                )
              : null,
          margin: EdgeInsets.only(bottom: 24),
          height: 32,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 8,
                height: 32,
                color: active ? Color(0xff454F63) : Colors.white,
              ),
              SizedBox(width: 32),
              Icon(icon, size: 20, color: Color(0xff3497FD)),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  height: 24 / 18,
                  color: Color(0xff454F63),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
