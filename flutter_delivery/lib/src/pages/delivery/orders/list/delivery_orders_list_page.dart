import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_controller.dart';

class DeliveryOrdersListPage extends StatefulWidget {
  DeliveryOrdersListPage({Key key}) : super(key: key);

  @override
  _DeliveryOrdersListPageState createState() => _DeliveryOrdersListPageState();
}

class _DeliveryOrdersListPageState extends State<DeliveryOrdersListPage> {
  DeliveryOrdersListController _controller = DeliveryOrdersListController();

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
        child: Text("Centro Delivery"),
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
                    "${_controller.user?.name ?? ''} ${_controller.user?.lastname ?? ''}",
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
                      image: AssetImage(
                        "assets/img/perfil6.jpeg",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("Editar Perfil"),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text("Meus Pedidos"),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
         ListTile(
            onTap: _controller.goToRoles,
            title: Text("Selecionar regra"),
            trailing: Icon(Icons.person),
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
