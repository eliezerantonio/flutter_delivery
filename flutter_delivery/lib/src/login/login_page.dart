import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/login/login_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _controller = new LoginController();

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
              child: Column(
                children: [
                  _lottieAnimation(),
                  _texFieldEmail(),
                  _texFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount()
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
              left: 25,
              child: _textLogin(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lottieAnimation() {
    return Container(
      margin: EdgeInsets.only(
        top: 130,
        bottom: MediaQuery.of(context).size.height * 0.07,
      ),
      child: Image.asset("assets/animation/man-delivery.gif",
          width: 350, height: 250, fit: BoxFit.cover),
    );
  }

  Widget _textLogin() {
    return Text("LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 22,
          fontFamily: 'NimbusSans',
        ));
  }

  Row _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tem uma conta?',
          style: TextStyle(
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: _controller.goToRegisterPage,
          child: Text(
            'Criar agora',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: ElevatedButton(
        onPressed: _controller.login,
        child: Text("Entrar"),
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

  Widget _imageBaner() {
    return Container(
      margin: EdgeInsets.only(
        top: 100,
        bottom: MediaQuery.of(context).size.height * 0.22,
      ),
      child: Image.asset(
        "assets/img/delivery.png",
        width: 200,
        height: 200,
      ),
    );
  }
}
