import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/login.bloc.dart';
import 'package:wetrek/blocs/states/authentication.state.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/location_repository.dart';
import 'package:wetrek/repositories/socket_repository.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/screens/splash_screen.dart';

// import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
void main() async {
  // await DotEnv.load(fileName: '.env');
//  AuthenticationRepository a = AuthenticationRepository();
//  await a.initToken();
  runApp(
    RepositoryProvider(
      create: (context) => AuthenticationRepository(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
        ),
      ],
      child: MultiRepositoryProvider(providers: [
        RepositoryProvider(
          create: (context) => SocketRepository(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocationRepository(),
        ),
      ], child: ViewNavigator()),
    );
  }
}
// create: (context) => SocketRepository(
//         authenticationRepository:
//             RepositoryProvider.of<AuthenticationRepository>(context)),

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
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }
}
