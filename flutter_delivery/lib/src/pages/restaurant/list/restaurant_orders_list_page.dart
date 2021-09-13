import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/restaurant/list/restaurant_orders_list_controller.dart';

class RestaunrantOrdersListPage extends StatefulWidget {
  RestaunrantOrdersListPage({Key key}) : super(key: key);

  @override
  _RestaunrantOrdersListPageState createState() =>
      _RestaunrantOrdersListPageState();
}

class _RestaunrantOrdersListPageState extends State<RestaunrantOrdersListPage> {
  RestaurantOrdersListController _controller = RestaurantOrdersListController();

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
      drawer: _drawer(),
      key: _controller.key,
      appBar: AppBar(
        leading: _menuDrawer(),
      ),
      body: Center(
        child: Text("Centro Restuarant"),
      ),
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _controller.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Image.asset(
          'assets/img/menu.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: Colors.red,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_controller.user?.name ?? ''} ${_controller.user?.lastname}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    "${_controller.user?.email ?? ''}",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Text(
                    "${_controller.user?.phone ?? ''}",
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[200],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    maxLines: 1,
                  ),
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 10),
                    child: FadeInImage(
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: _controller.user?.image != null
                          ? NetworkImage(_controller.user?.image)
                          : AssetImage("assets/img/no-image.png"),
                      image: _controller.user?.image != null
                          ? NetworkImage(_controller.user?.image)
                          : AssetImage("assets/img/no-image.png"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: _controller.goToCaregoryCreate,
            title: Text("Criar categoria"),
            trailing: Icon(Icons.list_alt),
          ),
          ListTile(
            onTap: _controller.goToRoles,
            title: Text("Selecionar regra"),
            trailing: Icon(Icons.person_outline),
          ),
          ListTile(
            onTap: _controller.logout,
            title: Text("Sair"),
            trailing: Icon(Icons.power_settings_new),
          ),
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
