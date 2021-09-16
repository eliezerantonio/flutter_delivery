import 'package:flutter/material.dart';

class ClientProductsDetailController {
  BuildContext context;

  Function refresh;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }
}
