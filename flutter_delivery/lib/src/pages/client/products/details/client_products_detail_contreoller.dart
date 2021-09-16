import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/product.dart';

class ClientProductsDetailController {
  BuildContext context;

  Function refresh;
  Product product;
  Future init(BuildContext context, Function refresh, Product product) {
    this.context = context;
    this.refresh = refresh;
    this.product = product;
  }
}
