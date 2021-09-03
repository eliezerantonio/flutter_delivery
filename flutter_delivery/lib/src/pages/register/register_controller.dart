import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';

class RegisterController {
  BuildContext context;
  //controladores
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  Future init(BuildContext context) {
    this.context = context;
    usersProvider.initState(context);
  }

  void backToLoginPage() {
    Navigator.pop(context);
  }

  void register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();
    String phone = phoneController.text.trim();

    User user = User(
        email: email,
        password: password,
        name: name,
        lastname: lastname,
        phone: phone);

    ResponseApi responseApi = await usersProvider.create(user);
    print(responseApi.toJson());
  }
}
