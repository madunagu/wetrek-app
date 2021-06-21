import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/authentication.event.dart';
import 'package:wetrek/blocs/login.bloc.dart';
import 'package:wetrek/blocs/states/authentication.state.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/categories_screen.dart';
import 'package:wetrek/screens/chat_screen.dart';
import 'package:wetrek/screens/history_screen.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/screens/nearby_screen.dart';
import 'package:wetrek/screens/notifications_screen.dart';
import 'package:wetrek/screens/path_screen.dart';
import 'package:wetrek/screens/phone_screen.dart';
import 'package:wetrek/screens/place_screen.dart';
import 'package:wetrek/screens/profile_screen.dart';
import 'package:wetrek/screens/statistics_screen.dart';
import 'package:wetrek/screens/terms_screen.dart';
import 'package:wetrek/screens/trek_screen.dart';
import 'package:wetrek/screens/trips_screen.dart';
import 'package:wetrek/screens/users_screen.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
void main() {
  // await DotEnv.load(fileName: '.env');
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({required this.authenticationRepository, required this.userRepository});
  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
            authenticationRepository: authenticationRepository,
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
//              userRepository: UserRepository(),
            authenticationRepository: AuthenticationRepository(),
          ),
        )
      ],
      child: MaterialApp(home: PathScreen()),
    );
  }
}

class ViewNavigator extends StatefulWidget {
  @override
  _ViewNavigatorState createState() => _ViewNavigatorState();
}

class _ViewNavigatorState extends State<ViewNavigator> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

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
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                    MapScreen.route(), (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                    LoginScreen.route(), (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => LoginScreen.route(),
    );
  }
}
