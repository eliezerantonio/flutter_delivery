import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientOrdersCreateController {
  BuildContext context;

  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;
  SharedPref _sharedPref = new SharedPref();
  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    selectedProducts =
        Product.fromJsonList(await _sharedPref.read("order")).toList;

    selectedProducts.forEach((product) {
      print(product);
    });
    refresh();
  }
}
