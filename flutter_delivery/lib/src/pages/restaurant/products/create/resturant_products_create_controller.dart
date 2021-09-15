import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';

import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/categories_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RestaurantProductsCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();
  CategoriesProvider _categoryProvider = new CategoriesProvider();
  User user;
  List<Category> categories = [];
  String idCategory;//categoria selecionada
  SharedPref _sharedPrefs = new SharedPref();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPrefs.read('user'));
    // _categoryProvider.init(context, user);
  }

  void createProduct() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Preencha todos campos');
      return;
    }
  }

  void getCategories() async {
    categories = await _categoryProvider.getAll();
    refresh();
  }
}
