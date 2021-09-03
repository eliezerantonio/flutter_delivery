import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/register/register_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController _controller = RegisterController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPersistentFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  _imageUser(),
                  _texFieldEmail(),
                  _texFieldName(),
                  _texFieldLastName(),
                  _texFieldPassword(),
                  _texFieldConfirmPassword(),
                  _buttonLogin(),
                ],
              ),
            ),
            Positioned(
              left: -100,
              top: -80,
              child: _circleLogin(),
            ),
            Positioned(
              top: 60,
              left: 10,
              child: _textRegister(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Widget _imageUser() {
    return Container(
      margin: EdgeInsets.only(
        top: 130,
        bottom: MediaQuery.of(context).size.height * 0.07,
      ),
      child: CircleAvatar(
        backgroundImage: AssetImage("assets/img/avatar.png"),
        radius: 55,
      ),
    );
  }

  Widget _textRegister() {
    return GestureDetector(
      onTap: () {
        _controller.backToLoginPage();
      },
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios, color: Colors.white),
          Text("REGISTRO",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: 'NimbusSans',
              )),
        ],
      ),
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: ElevatedButton(
        onPressed: _controller.register,
        child: Text("Cadastrar"),
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

  Widget _texFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'E-mail',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
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

  Widget _texFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.passwordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Senha',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.lock,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _texFieldConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _controller.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
          hintText: 'Confrima senha',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          prefixIcon: Icon(
            Icons.lock_open,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }
}
