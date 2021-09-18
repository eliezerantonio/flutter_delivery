import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientAddressMapController {
  BuildContext context;
  Function refresh;

  CameraPosition initialPositon =
      CameraPosition(target: LatLng(1.2125178, -8.34322), zoom: 14);



  Completer<GoogleMapController> mapController = Completer();

  
  Future init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;
  }

  void goToNewAddress() {
    Navigator.pushNamed(context, 'client/address/create');
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }
}
