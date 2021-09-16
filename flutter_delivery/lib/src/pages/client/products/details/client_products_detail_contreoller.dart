import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';

class ClientProductsDetailController {
  BuildContext context;

  Function refresh;
  Product product;

  int counter = 1;
  double productPrice;

  Future init(BuildContext context, Function refresh, Product product) {
    this.context = context;
    this.refresh = refresh;
    this.product = product;

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
}
