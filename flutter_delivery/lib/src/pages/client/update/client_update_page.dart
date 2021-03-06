import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/client/update/client_update_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class ClientUpdatePage extends StatefulWidget {
  ClientUpdatePage({Key key}) : super(key: key);

  @override
  _ClientUpdatePageState createState() => _ClientUpdatePageState();
}

class _ClientUpdatePageState extends State<ClientUpdatePage> {
  ClientUpdateController _controller = ClientUpdateController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar perfil"),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _imageUser(),
              _texFieldName(),
              _texFieldLastName(),
              _texFieldLastPhone(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buttonLogin(),
    );
  }

  Widget _imageUser() {
    return GestureDetector(
      onTap: _controller.showAlertDialog,
      child: Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.07,
          bottom: MediaQuery.of(context).size.height * 0.07,
        ),
        child: CircleAvatar(
          backgroundImage: _controller.imageFile != null
              ? FileImage(_controller.imageFile)
              : _controller.user?.image != null
                  ? NetworkImage(_controller.user?.image)
                  : AssetImage("assets/img/avatar.png"),
          radius: 55,
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: ElevatedButton(
        onPressed: _controller.isLoading ? null : _controller.update,
        child: Text("Atualizar"),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _texFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.nameController,
        decoration: InputDecoration(
          hintText: 'Nome',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.person,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _texFieldLastName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.lastnameController,
        decoration: InputDecoration(
          hintText: 'Apelido',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.person_rounded,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _texFieldLastPhone() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.phoneController,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: 'Telefone',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.phone,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
