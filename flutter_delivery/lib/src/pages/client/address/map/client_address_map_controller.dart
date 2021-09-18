import 'package:flutter/material.dart';

class ClientAddressMapController {
  BuildContext context;
  Function refresh;

  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void goToNewAddress() {
    Navigator.pushNamed(context, 'client/address/create');
  }
}
