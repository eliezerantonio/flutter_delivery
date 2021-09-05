import 'package:flutter/material.dart';

class RolesPage extends StatefulWidget {
  RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Regras"),
      ),
    );
  }
}
