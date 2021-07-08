import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => SplashScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
