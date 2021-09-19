import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'client_address_map_controller.dart';

class ClientAddressMapPage extends StatefulWidget {
  @override
  _ClientAddressMapPageState createState() => _ClientAddressMapPageState();
}

class _ClientAddressMapPageState extends State<ClientAddressMapPage> {
  ClientAddressMapController _con = ClientAddressMapController();
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Selecione a sua localizacao"),
        ),
        body: Stack(
          children: [_googleMaps(),],
        ));
  }

  Widget _googleMaps() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _con.initialPositon,
      onMapCreated: _con.onMapCreated,
    );
  }

  void refresh() {
    setState(() {});
  }
}
