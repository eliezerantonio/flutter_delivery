import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'client_address_list_controller.dart';

class ClientAddressListPage extends StatefulWidget {
  ClientAddressListPage({Key key}) : super(key: key);

  @override
  _ClientAddressListPageState createState() => _ClientAddressListPageState();
}

class _ClientAddressListPageState extends State<ClientAddressListPage> {
  ClientAddressListController _con = ClientAddressListController();
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
