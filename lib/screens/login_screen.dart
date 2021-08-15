import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wetrek/blocs/authentication.bloc.dart';
import 'package:wetrek/blocs/events/login.event.dart';
import 'package:wetrek/blocs/login.bloc.dart';
import 'package:wetrek/blocs/states/login.state.dart';
import 'package:wetrek/constants/text_styles.dart';
import 'package:wetrek/repositories/authentication_repository.dart';
import 'package:wetrek/repositories/user_repository.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: state.status.isValidated
                    ? () {
                        context.read<LoginBloc>().add(const LoginSubmitted());
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0xff3ACCE1),
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
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return MyInput(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          errorText: state.username.invalid
              ? state.validationErrors['email'] ?? state.username.error
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
          showDialog(
            context: context,
            builder: (BuildContext context) => ErrorPopup(
              title: 'Login Failed!',
              body: 'could not login due to error',
            ),
          );
        }
      },
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
          _LoginButton(),
        ]),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TabController tabController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  _onRegisterPressed() {
    context.read<LoginBloc>().add(
          RegisterSubmitted(
            firstName: firstNameController.value.text,
            lastName: lastNameController.value.text,
            email: emailController.value.text,
            password: passwordController.value.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 44),
        color: Color(0xffF7F7FA),
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          MyInput(
            hintText: 'First Name',
            controller: firstNameController,
          ),
          MyInput(
            hintText: 'Last Name',
            controller: lastNameController,
          ),
          MyInput(
            hintText: 'Email',
            controller: emailController,
          ),
          MyInput(
            hintText: 'Password',
            obscureText: true,
            controller: passwordController,
          ),
          SizedBox(
            height: 23,
          ),
          GestureDetector(
            onTap: _onRegisterPressed,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Color(0xff3ACCE1),
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
          ),
        ]),
      );
    });
  }
}
