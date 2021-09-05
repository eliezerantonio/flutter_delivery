import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/models/role.dart';

class RolesPage extends StatefulWidget {
  RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView()
    );
  }

  Widget _cardRole(Role role) {
    return Column(
      children: [
        Container(
          width: 100,
          child: FadeInImage(
            placeholder: AssetImage('assets/img/no-image.png'),
            image: role.image != null
                ? NetworkImage(role.image)
                : AssetImage('assets/img/no-image.png'),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
          ),
        ),
        Text(
          role.name ?? "",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
