import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/address.dart';
import 'package:flutter_delivery/src/models/order.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/provider/address_provider.dart';
import 'package:flutter_delivery/src/provider/orders_provider.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';

class ClientAddressListController {
  BuildContext context;
  Function refresh;
  List<Address> address = [];
  User user;
  SharedPref _sharedPref = new SharedPref();
  AddressProvider _addressProvider = new AddressProvider();

  int radioValue = 0;
  OrdersProvider _ordersProvider = new OrdersProvider();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    
    _addressProvider.init(context, user);
    _ordersProvider.init(context, user);

    refresh();
  }

  void handleRadioValueChange(int value) {
    radioValue = value;
    _sharedPref.save('address', address[value]);
    refresh();
  }

  void createOrder() async {
    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});
   final selectedProducts =
        Product.fromJson(await _sharedPref.read('order') ?? {}).toList;
    print(selectedProducts);
    Order order = new Order(
      idClient: user.id,
      idAddress: a.id,
      products: selectedProducts,
    );

    ResponseApi responseApi = await _ordersProvider.create(order);

    if (responseApi.success) {}
  }

  Future<List<Address>> getAddress() async {
    address = await _addressProvider.getByUser(user.id);

    Address a = Address.fromJson(await _sharedPref.read('address') ?? {});

    int index = address.indexWhere((ad) => ad.id == a.id);

    if (index != -1) {
      radioValue = index;
    }

    return address;
  }

  void goToNewAddress() async {
    var result = await Navigator.pushNamed(context, 'client/address/create');
    if (result != null) {
      if (result) {
        refresh();
      }
    }
  }
}
