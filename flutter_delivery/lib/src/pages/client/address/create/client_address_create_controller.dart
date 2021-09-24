import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/address/map/client_address_map_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientAddressCreateController {
  BuildContext context;
  Function refresh;

  TextEditingController refPointController = new TextEditingController();
  Map<String, dynamic> refPoint;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
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
