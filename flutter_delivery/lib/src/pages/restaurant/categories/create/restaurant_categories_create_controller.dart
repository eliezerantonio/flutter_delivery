import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/categories_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class RestaurantCategoriesCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   CategoriesProvider _categoryProvider = new CategoriesProvider();
  User user;
  SharedPref _sharedPrefs = new SharedPref();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPrefs.read('user'));
    _categoryProvider.init(context, user);
  }

  void createCategory() async {
    String name = nameController.text;
    String description = descriptionController.text;

    if (name.isEmpty || description.isEmpty) {
      MySnackbar.show(context, 'Preencha todos campos');
      return;
    }
    Category category = Category(name: name, description: description);
    ResponseApi responseApi = await _categoryProvider.create(category);

    if (responseApi.success) {
      nameController.text = "";
      descriptionController.text = "";
    }
  }
}
