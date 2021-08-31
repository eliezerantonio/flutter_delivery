import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            _imageBaner(),
            _texFieldEmail(),
            _texFieldPassword(),
            _buttonLogin(),
            _textDontHaveAccount()
          ],
        ),
      ),
    );
  }

  Row _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Tem uma conta?',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
        ),
        SizedBox(
          width: 7,
        ),
        Text(
          'Criar agora',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MyColors.primaryColor,
          ),
        ),
      ],
    );
  }

  ElevatedButton _buttonLogin() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Entrar"),
    );
  }

  Widget _texFieldEmail() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'E-mail',
      ),
    );
  }

  Widget _texFieldPassword() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Password',
      ),
    );
  }

  Widget _imageBaner() {
    return Image.asset(
      "assets/img/delivery.png",
      width: 200,
      height: 200,
    );
  }
}
