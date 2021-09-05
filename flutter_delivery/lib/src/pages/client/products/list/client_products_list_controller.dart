import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class ClientProductsListController {
  BuildContext context;
  SharedPref _shared_prefs = new SharedPref();

  Future init(BuildContext context) {
    this.context = context;
  }

  logout() {
    _shared_prefs.logout(context);
  }
}
