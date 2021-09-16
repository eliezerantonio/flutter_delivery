import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/client/orders/create/client_orders_create_controller.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  ClientOrdersCreatePage({Key key}) : super(key: key);

  @override
  _ClientOrdersCreatePageState createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {
  ClientOrdersCreateController _con = new ClientOrdersCreateController();
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
      body: Center(
        child: Text("Order"),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
