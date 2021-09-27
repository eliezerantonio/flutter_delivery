import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/address.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/address_provider.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class ClientAddressListController {
  BuildContext context;
  Function refresh;
  List<Address> address = [];
  User user;
  SharedPref _sharedPref = new SharedPref();
  AddressProvider _addressProvider = new AddressProvider();

  int radioValue = 0;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _addressProvider.init(context, user);
  }

  void handleRadioValueChange(int value) {
    radioValue = value;
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);

    return address;
  }

  void goToNewAddress() {
    Navigator.pushNamed(context, 'client/address/create');
  }
}
