import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

import 'client_address_create_controller.dart';

class ClientAddressCreatePage extends StatefulWidget {
  ClientAddressCreatePage({Key key}) : super(key: key);

  @override
  _ClientAddressCreatePageState createState() =>
      _ClientAddressCreatePageState();
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
        title: Text("Nova Endereco"),
      ),
      body: Container(
        child: Column( 
          children: [
            _textCompleteData(),
            _textFieldAddess(),
            _textFieldNeighbood(),
            _textFieldReferencePoint(),
            Spacer(),
            _buttpmAccept(),
          ],
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
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
        child: Text("Adicionar endereco"),
      ),
    );
  }

  Widget _textFieldAddess() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Endereco',
            suffixIcon: Icon(
              Icons.location_on,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFieldNeighbood() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Bairro',
            suffixIcon: Icon(
              Icons.location_on,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textFieldReferencePoint() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: TextField(
          onTap: _con.openMap,
          autofocus: false,
          focusNode: AlwaysDisabledFocusNode(),
          decoration: InputDecoration(
            labelText: 'Ponto de reference',
            suffixIcon: Icon(
              Icons.map,
              color: MyColors.primaryColor,
            ),
          ),
        ));
  }

  Widget _textCompleteData() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Text(
        "Complete os dados",
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
