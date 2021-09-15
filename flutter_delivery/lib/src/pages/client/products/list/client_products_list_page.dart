import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class ClientProductsListPage extends StatefulWidget {
  ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {
  ClientProductsListController _controller = ClientProductsListController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _controller.categories?.length,
      child: Scaffold(
        drawer: _drawer(),
        key: _controller.key,
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0,
            actions: [_shoppingBag()],
            flexibleSpace: Column(
              children: [
                SizedBox(
                  height: 43,
                ),
                _menuDrawer(),
                _textFieldSearch()
              ],
            ),
            bottom: TabBar(
              indicatorColor: MyColors.primaryColor,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              isScrollable: true,
              tabs:
                  List<Widget>.generate(_controller.categories.length, (index) {
                return Tab(
                  child: Text(_controller.categories[index].name ?? ''),
                );
              }),
            ),
          ),
          preferredSize: Size.fromHeight(140),
        ),
        body: TabBarView(
          children: _controller.categories.map((Category category) {
            return _cardProduct();
          }).toList(),
        ),
      ),
    );
  }

  Widget _cardProduct() {
    return Container(
      height: 200,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(15),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -1,
              right: -1,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(20))),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: FadeInImage(
                    image: AssetImage("assets/img/pizza2.png"),
                    placeholder: AssetImage("assets/img/no-image.png"),
                    fadeInDuration: Duration(seconds: 3),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _shoppingBag() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 15, top: 15),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
        ),
        Positioned(
          right: 16,
          top: 15,
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(30)),
          ),
        )
      ],
    );
  }

  Widget _textFieldSearch() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: TextField(
        decoration: InputDecoration(
            hintText: "Buscar",
            suffixIcon: Icon(
              Icons.search,
              color: Colors.grey[400],
            ),
            hintStyle: TextStyle(
              color: Colors.grey[500],
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              borderSide: BorderSide(
                color: Colors.grey[300],
              ),
            ),
            contentPadding: EdgeInsets.all(15)),
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
                      image: AssetImage(
                        "assets/img/no-image.png",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            onTap: _controller.goToUpdate,
            title: Text("Editar Perfil"),
            trailing: Icon(Icons.edit_outlined),
          ),
          ListTile(
            title: Text("Meus Pedidos"),
            trailing: Icon(Icons.shopping_cart_outlined),
          ),
          if (_controller.user != null && _controller.user.roles.length > 1)
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
