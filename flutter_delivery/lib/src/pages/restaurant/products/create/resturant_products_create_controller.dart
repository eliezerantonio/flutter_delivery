import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/response_api.dart';

import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/categories_provider.dart';
import 'package:flutter_delivery/src/provider/products_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class RestaurantProductsCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();
  CategoriesProvider _categoryProvider = new CategoriesProvider();

  ProductsProvider _productsProvider = new ProductsProvider();

  User user;
  List<Category> categories = [];
  String idCategory; //categoria selecionada
  SharedPref _sharedPrefs = new SharedPref();

  XFile pickedFile;
  File imageFile1;
  File imageFile2;
  File imageFile3;

  ProgressDialog _progressDialog;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _progressDialog = new ProgressDialog(context: context);

    user = User.fromJson(await _sharedPrefs.read('user'));
    _categoryProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = priceController.numberValue;

    if (name.isEmpty || description.isEmpty || price == 0) {
      MySnackbar.show(context, 'Preencha todos campos');
      return;
    }

    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      MySnackbar.show(context, 'Selecione as 3 imagens');
      return;
    }
    if (idCategory == null) {
      MySnackbar.show(context, 'Selecione a categoria');
      return;
    }

    Product product = new Product(
        description: description,
        price: price,
        name: name,
        idCategory: int.parse(idCategory));

    List<File> images = [];

    images.add(imageFile1);
    images.add(imageFile2);
    images.add(imageFile3);

    _progressDialog.show(max: 100, msg: "Salvando...");
    Stream stream = await _productsProvider.create(product, images);

    stream.listen((response) {
      _progressDialog.close();

      ResponseApi responseApi = ResponseApi.fromJson(json.decode(response));

      MySnackbar.show(context, responseApi.message);

      if (responseApi.success) {
        reseValues();
      }
    });
  }

  void getCategories() async {
    categories = await _categoryProvider.getAll();
    refresh();
  }

  void showAlertDialog(int numberFile) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.gallery, numberFile);
      },
      child: Text("Galeria"),
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        selectImage(ImageSource.camera, numberFile);
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

  Future selectImage(ImageSource imageSource, int numberFile) async {
    pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      if (numberFile == 1) {
        imageFile1 = File(pickedFile.path);
      } else if (numberFile == 2) {
        imageFile2 = File(pickedFile.path);
      } else if (numberFile == 3) {
        imageFile3 = File(pickedFile.path);
      }
    }
    Navigator.of(context).pop();
    refresh();
  }

  void reseValues() {
    nameController.text = '';
    descriptionController.text = '0.0';
    priceController.text = '0.0';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory = null;
    refresh();
  }
}
