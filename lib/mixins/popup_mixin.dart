import 'package:flutter/material.dart';
import 'package:wetrek/network/exceptions.dart';
import 'package:wetrek/screens/login_screen.dart';
import 'package:wetrek/widgets/widgets.dart';


mixin MyPopupMixin<T extends StatefulWidget> on State<T> {
  showError(Exception e) {
    if (e is AuthenticationException) {
      showDialog(
        context: context,
        builder: (BuildContext context) => DialogPopup(
          title: 'Error Occurred!',
          body: e.toString(),
          okFunction: () => Navigator.of(context).push(LoginScreen.route()),
          okText: 'LOGOUT',
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) => ErrorPopup(
        title: 'Error Occurred!',
        body: e.toString(),
      ),
    );
  }

  void showLoader() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => LoadingPopup(),
    );
  }

  void hideLoader() {
    Navigator.pop(context);
  }

}


