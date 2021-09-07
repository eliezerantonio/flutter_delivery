import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';

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

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty ||
        name.isEmpty ||
        lastname.isEmpty) {
      MySnackbar.show(context, "Preencha todos campos");
      return;
    }
    if (password.isEmpty != confirmPassword.isEmpty) {
      MySnackbar.show(context, "Senhas Diferentes");
      return;
    }
    if (password.length < 6) {
      MySnackbar.show(context, "Senha muito curta");
      return;
    }

    User user = User(
        email: email,
        password: password,
        name: name,
        lastname: lastname,
        phone: phone);
    ResponseApi responseApi = await usersProvider.create(user);

    MySnackbar.show(context, responseApi.message);

    if (responseApi.success) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushNamed(context, 'login');
      });
    }
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
      onPressed: () {},
      child: Text("Galeria"),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {},
      child: Text("Camera"),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Selecionar imagem"),
      actions: [
        galleryButton,
        cameraButton,
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
