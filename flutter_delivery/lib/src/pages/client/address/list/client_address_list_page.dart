import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';

import 'client_address_list_controller.dart';

class ClientAddressListPage extends StatefulWidget {
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
        title: Text("Enderecos"),
        actions: [
          _iconAdd(),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            _textSelectAddress(),
            NoDataWidget(text: "Adicione um endereco"),
            _buttonShopingBag(),
            Spacer(),
            _buttpmAccept(),
          ],
        ),
      ),
    );
  }

  Widget _buttonShopingBag() {
    return Container(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: Text(
          "Novo endereco",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buttpmAccept() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 44,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: MyColors.primaryColor,
        ),
        child: Text("Confirmar"),
      ),
    );
  }

  Widget _textSelectAddress() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        "Escolha um local para receber",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _iconAdd() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: _con.goToNewAddress,
    );
  }

  void refresh() {
    setState(() {});
  }
}
