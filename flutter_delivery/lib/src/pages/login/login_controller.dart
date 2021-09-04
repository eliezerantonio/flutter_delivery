import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';

class LoginController {
  BuildContext context;
  //controladores
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.initState(context);
  }

  void goToRegisterPage() {
    if (context != null) {
      Navigator.pushNamed(context, 'register');
    }
  }

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;
    ResponseApi responseApi = await usersProvider.login(email, password);
    MySnackbar.show(context, responseApi.message ?? "");
  }
}
