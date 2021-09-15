import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/categories_provider.dart';
import 'package:flutter_delivery/src/provider/products_provider.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ClientProductsListController {
  BuildContext context;
  SharedPref _sharedPrefs = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  MoneyMaskedTextController priceController = MoneyMaskedTextController();

  List<Category> categories = [];
  ProductsProvider _productsProvider = new ProductsProvider();

  User user;
  CategoriesProvider _categoryProvider = new CategoriesProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPrefs.read('user'));
    _categoryProvider.init(context, user);
    getCategories(refresh);
    _productsProvider.init(context, user);
    refresh();
  }

  void logout() {
    _sharedPrefs.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdate() {
    Navigator.pushNamed(
      context,
      'client/update',
    );
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);
  }

  void getCategories(Function refresh) async {
    categories = await _categoryProvider.getAll();
    refresh();
  }
}
