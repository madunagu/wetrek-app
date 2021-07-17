import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/states/authentication.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/widgets/widgets.dart';

class EditProfile extends StatefulWidget {
  static route() {
    return MaterialPageRoute(builder: (context) => EditProfile());
  }

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late User user;

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    User? _user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    if (_user == null) logout();
    user = _user!;
    initControllers();
    super.initState();
  }

  void logout() {
    //TODO: implement logout
  }

  catchExceptions(e) {
    List<String> _m = ['ERROR OCCURRED', 'Could not Send Message'];
    if (e is MyException) _m[1] = e.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) => NotificationPopup(
        title: _m[0],
        body: _m[1],
      ),
    );
  }

  void initControllers() {
    firstNameController = TextEditingController(text: user.firstName);
    lastNameController = TextEditingController(text: user.lastName);

    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _submitForm() async {
    UserRepository rep = UserRepository(
        RepositoryProvider.of<AuthenticationRepository>(context).token);
    User updatedUser = User(
      email: emailController.value.text,
      firstName: firstNameController.value.text,
      lastName: lastNameController.value.text,
      id: user.id,
      avatar: '',
      following: [],
      token: '',
    );
    try {
      User u = await rep.update(updatedUser);
      //TODO: refresh the auth repository
    } catch (e) {
      catchExceptions(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profile'),
      body: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'images/avatar1.jpg',
                width: 128,
                height: 128,
              ),
            ),
            SizedBox(height: 20),
            Text('Maria Snow', style: TextStyles.darkLarge),
            Text('San Fransico CA', style: TextStyles.darkNormal),
            // Nick name or alias should be part of the profile
            SizedBox(height: 23),
            MyInput(controller: firstNameController, hintText: 'First Name'),
            MyInput(controller: lastNameController, hintText: 'Last Name'),
            MyInput(controller: emailController, hintText: 'Email'),
            MyButton('SUBMIT', onTap: _submitForm),
          ],
        ),
      ),
    );
  }
}
