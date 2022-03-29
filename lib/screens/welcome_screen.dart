import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/screens/map_screen.dart';
import '../widgets/widgets.dart';
import 'package:wetrek/widgets/dotted_tab_bar.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();

  static MaterialPageRoute<WelcomeScreen> route() {
    return MaterialPageRoute(builder: (context) => WelcomeScreen());
  }
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    registerWelcome();
    super.initState();
  }

  registerWelcome() async {
    AuthenticationRepository rep =
        RepositoryProvider.of<AuthenticationRepository>(context);
    await rep.saveCookie('user_welcomed');
    Future.delayed(Duration.zero, () {
      Navigator.push(context, MapScreen.route());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.asset(
              'images/museum.jpg',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            DottedTabBar(),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  children: [
                    Text(
                      'Welcome To WeTrek',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 52,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'The best way to navigate your world and discover new places. Let\'s get started!',
                      style: TextStyles.base,
                    ),
                    SizedBox(height: 38),
                    Text(
                      'CONTINUE WITH',
                      style: TextStyles.minor.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    MyButton('EMAIL', onTap: registerWelcome,),
                    SizedBox(height: 12),
                    MyButton('SOCIAL'),
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
