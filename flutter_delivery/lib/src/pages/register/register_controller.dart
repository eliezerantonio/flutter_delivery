import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:image_picker/image_picker.dart';

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
  XFile pickedFile;
  File imageFile;
  Function refresh;
  Future init(BuildContext context, Function refresh) {
    this.context = context;
    usersProvider.initState(context);
    this.refresh = refresh;
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

    if (imageFile == null) {
      MySnackbar.show(context, "Selecione uma imagem");
    }

    User user = User(
        email: email,
        password: password,
        name: name,
        lastname: lastname,
        phone: phone);

    Stream stream = await usersProvider.createWithImage(user, imageFile);
    stream.listen((res) {
      // ResponseApi responseApi=await usersProvider.create(user);
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, 'login');
        });
      }
    });
  }

  void showAlertDialog() {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery);
      },
      child: Text("Galeria"),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera);
      },
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

  Future selectImage(ImageSource imageSource) async {
    pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    Navigator.of(context).pop();
    refresh();
  }
}
