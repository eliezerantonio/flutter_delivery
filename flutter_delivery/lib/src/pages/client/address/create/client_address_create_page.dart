import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'client_address_create_controller.dart';

class ClientAddressCreatePage extends StatefulWidget {
  ClientAddressCreatePage({Key key}) : super(key: key);

  @override
  _ClientAddressCreatePageState createState() => _ClientAddressCreatePageState();
}

class _ClientAddressCreatePageState extends State<ClientAddressCreatePage> {
  ClientAddressCreateController _con = ClientAddressCreateController();
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
        title: Text("Nova direcao"),
      ),
    );
  }


  void refresh(){
    setState(() {
      
    });
  }
}
