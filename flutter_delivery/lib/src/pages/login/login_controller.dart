import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class LoginController {
  BuildContext context;
  //controladores
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  SharedPref _sharedPref = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    await usersProvider.initState(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print(user.toJson());
    if (user?.sessionToken != null) {
      Navigator.pushReplacementNamed(context, 'client/products/list');
    }
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
    if (responseApi.success) {
      User user = User.fromJson(responseApi.data);

      print("Usuario logado: ${user.toJson()}");

      _sharedPref.save('user', user.toJson());
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    } else {
      MySnackbar.show(context, responseApi.message);
    }
  }
}
