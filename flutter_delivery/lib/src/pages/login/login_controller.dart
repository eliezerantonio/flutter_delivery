import 'package:flutter/material.dart';

class LoginController {
  BuildContext context;
  //controladores
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future init(BuildContext context) {
    this.context = context;
  }

  void goToRegisterPage() {
    if (context != null) {
      Navigator.pushNamed(context, 'register');
    }
  }

  void login() {
    String email = emailController.text;
    String password = passwordController.text;
  }
}
