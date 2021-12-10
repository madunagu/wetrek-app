import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/map_screen.dart';
import 'package:wetrek/screens/payment_screen.dart';
import 'package:wetrek/widgets/widgets.dart';

class PhoneScreen extends StatefulWidget {
  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => PhoneScreen(),
    );
  }

  @override
  _PhoneScreenState createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late final TextEditingController _phoneController;
  late final User user;

  @override
  void initState() {
    _phoneController = TextEditingController();
    super.initState();
  }

  catchExceptions(e) {
    List<String> _m = ['ERROR OCCURRED', 'Could not Send Message'];
    if (e is MyException) _m[1] = e.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopup(
        title: _m[0],
        body: _m[1],
      ),
    );
  }

  void _submitForm() async {
    showDialog(
      context: context,
      builder: (BuildContext context) => LoadingPopup(),
    );
    user = BlocProvider.of<AuthenticationBloc>(context).state.user!;

    UserRepository userRepository = UserRepository(
        RepositoryProvider.of<AuthenticationRepository>(context).token);
    User updatedUser = user.copyWith(phone: _phoneController.value.text);
    try {
      User u = await userRepository.update(updatedUser);
      RepositoryProvider.of<AuthenticationRepository>(context).refresh(u);
      Navigator.push(context, MapScreen.route());
    } catch (e, _) {
      print(_);
      Navigator.pop(context);
      catchExceptions(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color(0xff2A2E43),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 56),
            child: Column(
              children: [
                Text(
                  'Enter your phone number',
                  style: TextStyles.title.copyWith(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 38),
                MyInput(
                  isDark: true,
                  controller: _phoneController,
                ),
                SizedBox(height: 56),
                MyButton('NEXT STEP', onTap: _submitForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
