import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/models/location.dart';
import 'package:wetrek/models/user.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
import 'package:wetrek/screens/profile_screen.dart';
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
  late TextEditingController nameController;
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

  void logout() async {
    RepositoryProvider.of<AuthenticationRepository>(context).logOut();
  }

  String readableAddress() {
    Location myLocation = user.locations.isNotEmpty
        ? user.locations.last
        : Location(lat: 1, lng: 1);

    return "Visible Address";
  }

  catchExceptions(e) {
    List<String> _m = ['ERROR OCCURRED', 'Could not Send Message'];
    if (e is MyException) _m[1] = e.toString();
    showDialog(
      context: context,
      builder: (BuildContext context) => Popup(
        title: _m[0],
        body: _m[1],
      ),
    );
  }

  void initControllers() {
    nameController = TextEditingController(text: user.name);
//    lastNameController = TextEditingController(text: user.lastName);

    emailController = TextEditingController(text: user.email);
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void _submitForm() async {
    UserRepository userRepository = UserRepository(
        RepositoryProvider.of<AuthenticationRepository>(context).token);
    User updatedUser = user.copyWith(
//      email: emailController.value.text,
      name: nameController.value.text,
    );
    try {
      User u = await userRepository.update(updatedUser);
      RepositoryProvider.of<AuthenticationRepository>(context).refresh(u);
      Navigator.push(context, ProfileScreen.route(u));
    } catch (e, _) {
      print(_);
      catchExceptions(e);
    }
  }

  Future<String> readableLocation(List<Location> location) async {
    await Future.delayed(Duration.zero);
//    Address address = AddressRepository(RepositoryProvider.of<AuthenticationRepository>(context).token).get(id);
    return 'Location';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'Edit Profile'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 18),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  user.picture.large,
                  width: 128,
                  height: 128,
                ),
              ),
              SizedBox(height: 20),
              Text(user.name, style: TextStyles.darkLarge),
              Text(readableAddress(), style: TextStyles.darkNormal),
              SizedBox(height: 23),
              MyInput(controller: nameController, hintText: 'Name'),
//            MyInput(controller: lastNameController, hintText: 'Last Name'),
              MyInput(controller: emailController, hintText: 'Email'),
              MyButton('SUBMIT', onTap: _submitForm),
            ],
          ),
        ),
      ),
    );
  }
}
