import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class ClientProductsListController {
  BuildContext context;
  SharedPref _shared_prefs = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  User user;
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    user = User.fromJson(await _shared_prefs.read('user'));
    refresh();
  }

  void logout() {
    _shared_prefs.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToUpdate() {
    Navigator.pushNamedAndRemoveUntil(
        context, 'client/update', (route) => false);
  }
}
