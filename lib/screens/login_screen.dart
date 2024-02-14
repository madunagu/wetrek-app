import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/events/login.event.dart';
import 'package:wetrek/blocs/login.bloc.dart';
import 'package:wetrek/blocs/states/login.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/screens/welcome_screen.dart';
import 'package:wetrek/widgets/widgets.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

  static MaterialPageRoute<LoginScreen> route() {
    return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    checkUserWelcomed();
    super.initState();
  }

  checkUserWelcomed() async {
    AuthenticationRepository rep =
        RepositoryProvider.of<AuthenticationRepository>(context);
    bool isUserWelcomed = await rep.isCookieSaved('user_welcomed');
    if (!isUserWelcomed) {
      Navigator.push(context, WelcomeScreen.route());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                height: 73,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xfff4f4f6)),
                  ),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.all(0),
                  indicator: BlueDashGradientDecoration(height: 6),
                  unselectedLabelColor: Color(0xff959DAD),
                  labelColor: Color(0xff454F63),
                  tabs: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Color(0xfff4f4f6)),
                        ),
                      ),
                      child: Tab(
                          child: Text(
                        'SIGN IN',
                        style: TextStyles.tab,
                      )),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(color: Color(0xfff4f4f6)),
                        ),
                      ),
                      child: Tab(
                          child: Text(
                        'SIGN UP',
                        style: TextStyles.tab,
                      )),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height - 122,
                child: TabBarView(children: [
                  LoginForm(),
                  RegisterForm(),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  _LoginButton({required this.onTap});
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap:
                    //  state.status.isValidated ?
                    () {
                  onTap();
                }
                // : null
                ,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: state.status.isValidated
                        ? Color(0xff3ACCE1)
                        : Color(0xffE9EBEF),
                  ),
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'CONTINUE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.333,
                    ),
                  ),
                ),
              );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(LoginEmailChanged(email)),
          errorText: state.email.invalid
              ? state.validationErrors['email'] ?? state.email.error
              : null,
          hintText: 'Email',
        );
      },
    );
  }
}

class _RegisterEmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) =>
              context.read<LoginBloc>().add(RegisterEmailChanged(email)),
          errorText: state.email.invalid
              ? state.validationErrors['email'] ?? state.email.error
              : null,
          hintText: 'Email',
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          obscureText: true,
          hintText: 'Password',
          errorText: state.password.invalid
              ? state.validationErrors['password'] ?? state.password.error
              : null,
        );
      },
    );
  }
}

class _RegisterPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginBloc>().add(RegisterPasswordChanged(password)),
          obscureText: true,
          hintText: 'Password',
          errorText: state.password.invalid
              ? state.validationErrors['password'] ?? state.password.error
              : null,
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_firstNameInput_textField'),
          onChanged: (firstName) => context
              .read<LoginBloc>()
              .add(RegisterFirstNameChanged(firstName)),
          errorText: state.firstName.invalid
              ? state.validationErrors['first_name'] ?? state.firstName.error
              : null,
          hintText: 'First Name',
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_lastNameInput_textField'),
          onChanged: (lastName) =>
              context.read<LoginBloc>().add(RegisterLastNameChanged(lastName)),
          errorText: state.lastName.invalid
              ? state.validationErrors['last_name'] ?? state.lastName.error
              : null,
          hintText: 'Last Name',
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) =>
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_confirmPasswordInput_textField'),
          obscureText: true,
          onChanged: (password) => context
              .read<LoginBloc>()
              .add(RegisterConfirmPasswordChanged(password)),
          errorText: state.confirmPassword.invalid
              ? state.validationErrors['password'] ?? state.password.error
              : null,
          hintText: 'Confirm Password',
        );
      },
    );
  }
}

class LoginForm extends StatelessWidget {
  onForgotPassword(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Popup(
        body: 'Hello!',
        title: 'Popup Title',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status.isSubmissionFailure) {
          switch (state.error.runtimeType) {
            case SocketException:
              showDialog(
                context: context,
                builder: (BuildContext context) => ErrorPopup(
                  title: 'NETWORK ERROR OCCURED',
                  body: state.error.toString(),
                ),
              );
              break;
            default:
              showDialog(
                context: context,
                builder: (BuildContext context) => ErrorPopup(
                  title: 'LOGIN FAILED!',
                  body: state.error.toString(),
                ),
              );
          }
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 44),
          color: Color(0xffF7F7FA),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 122,
          child: Column(children: [
            _EmailInput(),
            _PasswordInput(),
            SizedBox(
              height: 13,
            ),
            GestureDetector(
              onTap: () {
                onForgotPassword(context);
              },
              child: Text(
                'FORGOT PASSWORD?',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0x9078849E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 47,
            ),
            _LoginButton(
              onTap: () {
                context.read<LoginBloc>().add(const LoginSubmitted());
              },
            ),
          ]),
        ),
      ),
    );
  }
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state.status.isSubmissionFailure) {
          switch (state.error.runtimeType) {
            case SocketException:
              showDialog(
                context: context,
                builder: (BuildContext context) => ErrorPopup(
                  title: 'NETWORK ERROR OCCURED',
                  body: state.error.toString(),
                ),
              );
              break;
            default:
              showDialog(
                context: context,
                builder: (BuildContext context) => ErrorPopup(
                  title: 'REGISTRATION FAILED!',
                  body: state.error.toString(),
                ),
              );
          }
        }
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 44),
          color: Color(0xffF7F7FA),
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            _FirstNameInput(),
            _LastNameInput(),
            _RegisterEmailInput(),
            _RegisterPasswordInput(),
            _ConfirmPasswordInput(),
            SizedBox(
              height: 23,
            ),
            _LoginButton(
              onTap: () {
                context.read<LoginBloc>().add(const RegisterSubmitted());
              },
            ),
          ]),
        ),
      ),
    );
  }
}
