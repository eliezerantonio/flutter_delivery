import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ClientProductsDetailController {
  BuildContext context;

  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;
  SharedPref _sharedPref = new SharedPref();
  List<Product> selectedProducts = [];

  Future init(BuildContext context, Function refresh, Product product) async {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
    this.productPrice = product.price;

    selectedProducts =
        Product.fromJsonList(await _sharedPref.read("order")).toList;

    selectedProducts.forEach((product) {
      print(product);
    });

    refresh();
  }

  void addItem() {
    counter = counter + 1;
    productPrice = product.price * counter;
    product.quantity = counter;
    refresh();
  }

  void removeItem() {
    if (counter > 1) {
      counter = counter - 1;
      productPrice = product.price * counter;
      product.quantity = counter;
      refresh();
    }
  }

  void close() {
    Navigator.pop(context);
  }

  void addToBag() {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      //nao esta nocarinho

      if (product.quantity == null) {
        product.quantity = 1;
      }

      selectedProducts.add(product);
    } else {
      //se ja existe aumenta apenas  qtd
      selectedProducts[index].quantity =
          selectedProducts[index].quantity + counter;
    }
    _sharedPref.save("order", selectedProducts);
    Fluttertoast.showToast(msg: "Produto adicionado");
    Navigator.pop(context);
  }
}
