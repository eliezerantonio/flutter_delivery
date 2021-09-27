import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/address.dart';
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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: _textSelectAddress(),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: _listAddress(),
          ),
        ],
      ),
      bottomNavigationBar: _buttpmAccept(),
    );
  }

  Widget _noAddress() {
    return Column(
      children: [
        _textSelectAddress(),
        NoDataWidget(text: "Adicione um endereco"),
        _buttonShopingBag(),
      ],
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

  Widget _listAddress() {
    return FutureBuilder(
      future: _con.getAddress(),
      builder: (context, AsyncSnapshot<List<Address>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              itemBuilder: (_, index) {
                return _radioSelectorAddress(snapshot.data[index], index);
              },
            );
          } else {
            return _noAddress();
          }
        } else {
          return _noAddress();
        }
      },
    );
  }

  Widget _buttpmAccept() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 44,
      child: ElevatedButton(
        onPressed: _con.goToNewAddress,
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          primary: MyColors.primaryColor,
        ),
        child: Text("Confirmar"),
      ),
    );
  }

  Widget _radioSelectorAddress(Address address, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Radio(
                value: index,
                groupValue: _con.radioValue,
                onChanged: _con.handleRadioValueChange,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address?.address ?? '',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    address?.neighborhood ?? '',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Divider(color: Colors.grey),
        ],
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
