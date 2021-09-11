import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/users_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class ClientUpdateController {
  BuildContext context;
  //controladores
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();
  XFile pickedFile;
  File imageFile;
  Function refresh;
  ProgressDialog _progressDialog;
  bool isLoading = false;

  User user;
  SharedPref _sharedPrefs = new SharedPref();

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.usersProvider.initState(context);
    this.refresh = refresh;
    this._progressDialog = ProgressDialog(context: context);
    this.user = User.fromJson(await _sharedPrefs.read('user'));
    this.nameController.text = user.name;
    this.phoneController.text = user.phone;
    this.lastnameController.text = user.lastname;
    this.refresh();
  }

  void backToLoginPage() {
    Navigator.pop(context);
  }

  void update() async {
    String name = nameController.text.trim();
    String lastname = lastnameController.text.trim();
    String phone = phoneController.text.trim();

    if (phone.isEmpty || name.isEmpty || lastname.isEmpty) {
      MySnackbar.show(context, "Preencha todos campos");
      return;
    }

    if (imageFile == null) {
      MySnackbar.show(context, "Selecione uma imagem");
    }
    _progressDialog.show(max: 100, msg: "Atualizando");
    isLoading = true;
    User myUser = User(
      id: user.id,
      name: name,
      lastname: lastname,
      phone: phone,
    );

    Stream stream = await usersProvider.update(myUser, imageFile);
    stream.listen((res) async {
      // ResponseApi responseApi=await usersProvider.create(user);
      _progressDialog.close();
      isLoading = false;
      ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

      if (responseApi.success) {
        user = await usersProvider.getById(
            myUser.id); //obter usuario da base e guardar e, shared prefs
        _sharedPrefs.save(
          'user',
          user.toJson(),
        );
        Fluttertoast.showToast(msg: responseApi.message);

        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamed(context, 'client/products/list');
        });
      } else {
        isLoading = false;
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
