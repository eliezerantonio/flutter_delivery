import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class DeliveryOrdersListController {
  BuildContext context;
  SharedPref _sharedPrefs = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  User user;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _sharedPrefs.read('user'));
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
}
