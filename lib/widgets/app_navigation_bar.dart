import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/constants/colors.dart';
import 'package:wetrek/presentation/custom_icons.dart';
import 'package:wetrek/screens/messages_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/screens/trips_screen.dart';
import 'widgets.dart';

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
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  height: 250,
                  width: 325,
                  color: Color(0xff2A2E43),
                ),
                Opacity(
                  opacity: .18,
                  child: Image.asset(
                    'images/ice_cream.jpg',
                    width: 325,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
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
            padding: EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerLink(
                  title: 'Home',
                  active: true,
                  icon: Icons.home_outlined,
                ),
                DrawerLink(
                  title: 'Treks',
                  icon: Icons.directions_walk,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TripsScreen()));
                  },
                ),
                DrawerLink(
                  icon: CustomIcons.icons_comment,
                  title: 'Chats',
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MessagesScreen()));
                  },
                ),
                DrawerLink(
                  title: 'Events',
                ),
              ],
            ),
          ),
          Spacer(),
          DrawerLink(
            title: 'Logout',
            icon: Icons.logout,
            onTap: (){
              BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLogoutRequested());
            },
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
                color: active ? Color(0xff3497FD) : Colors.white,
              ),
              SizedBox(width: 32),
              Icon(icon,
                  size: 20,
                  color: active ? Color(0xff3497FD) : Color(0xff454F63)),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
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
