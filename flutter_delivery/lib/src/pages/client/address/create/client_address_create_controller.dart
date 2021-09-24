import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/address.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:flutter_delivery/src/pages/client/address/map/client_address_map_page.dart';
import 'package:flutter_delivery/src/provider/address_provider.dart';
import 'package:flutter_delivery/src/utils/my_snackbar.dart';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController refPointController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController neighborhoodController = new TextEditingController();
  Map<String, dynamic> refPoint;
  User user;

  SharedPref _sharedPrefs = new SharedPref();

  AddressProvider _addressProvider = new AddressProvider();
  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPrefs.read('user'));
    _addressProvider.init(context, user);
  }

  void createAddress() async {
    String addressName = addressController.text;
    String neighborhood = neighborhoodController.text;

    double lat = refPoint['lat'] ?? 0;
    double lng = refPoint['lng'] ?? 0;

    if (addressName.isEmpty || neighborhood.isEmpty || lat == 0 || lng == 0) {
      MySnackbar.show(context, 'Preencha todos cmapos');
      return;
    }
    Address address = new Address(
        address: addressName, neighborhood: neighborhood, lat: lat, lng: lng);

    ResponseApi responseApi = await _addressProvider.create(address);

    if (responseApi.success) {
      Fluttertoast.showToast(msg: responseApi.message);
      Navigator.pop(context);
    }
  }

  void openMap() async {
    refPoint = await showMaterialModalBottomSheet(
        enableDrag: false,
        context: context,
        builder: (context) => ClientAddressMapPage());

    if (refPoint != null) {
      refPointController.text = refPoint["address"];
      refresh();
    }
  }
}
