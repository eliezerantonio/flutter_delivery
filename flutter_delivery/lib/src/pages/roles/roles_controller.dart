import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class RolesController {
  BuildContext context;
  User user;
  SharedPref _sharedPrefs = new SharedPref();
  Future init(BuildContext context) async {
    this.context = context;
//obtendo usuario de sesssao
    user = User.fromJson(await _sharedPrefs.read('user'));
  }
}
