import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/role.dart';
import 'package:flutter_delivery/src/pages/roles/roles_controller.dart';

class RolesPage extends StatefulWidget {
  RolesPage({Key key}) : super(key: key);

  @override
  _RolesPageState createState() => _RolesPageState();
}

class _RolesPageState extends State<RolesPage> {
  RolesController rolesController = new RolesController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      rolesController.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: ListView(
            children: rolesController.user != null
                ? rolesController.user.roles
                    .map((role) => _cardRole(role))
                    .toList()
                : []),
      ),
    );
  }

  Widget _cardRole(Role role) {
  
    return GestureDetector(
      onTap:()=>rolesController.goToPage(role.route),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.png'),
              image: role.image != null
                  ? NetworkImage(role.image)
                  : AssetImage(
                      'assets/img/no-image.png',
                    ),
              fit: BoxFit.contain,
              fadeInDuration: Duration(milliseconds: 50),
            ),
          ),
          Text(
            role.name ?? "",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
