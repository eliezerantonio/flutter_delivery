import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class DeliveryOrdersListController {
  BuildContext context;
  SharedPref _shared_prefs = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Future init(BuildContext context) {
    this.context = context;
  }

  void logout() {
    _shared_prefs.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }
}
