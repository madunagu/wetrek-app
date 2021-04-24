import 'package:flutter/material.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/screens/history_screen.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/screens/notifications_screen.dart';
import 'package:wetrek/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Gibson',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapScreen(),
    );
  }
}

