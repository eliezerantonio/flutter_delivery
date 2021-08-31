import 'package:flutter/cupertino.dart';

class LoginController {
  late BuildContext context;

  Future? init(BuildContext context) {
    this.context = context;
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }
}
