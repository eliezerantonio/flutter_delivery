import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class RolesController {
  Function refresh;
  BuildContext context;
  User user;
  SharedPref _sharedPrefs = new SharedPref();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
//obtendo usuario de sesssao
    user = User.fromJson(await _sharedPrefs.read('user'));
    refresh();
  }
}
