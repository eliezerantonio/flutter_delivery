import 'package:flutter/material.dart';

class RegisterController {
  late BuildContext context;
  //controladores
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future? init(BuildContext context) {
    this.context = context;
  }

  void backToLoginPage() {
    Navigator.pop(context);
  }

  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String lastname = lastnameController.text;
    String confirmPassword = confirmPasswordController.text;
    String phone = phoneController.text;
  }
}
