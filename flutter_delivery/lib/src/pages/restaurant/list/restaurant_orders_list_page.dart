import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/pages/restaurant/list/restaurant_orders_list_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';

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
    return DefaultTabController(
      length: _controller.categories?.length,
      child: Scaffold(
        drawer: _drawer(),
        key: _controller.key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(170),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            flexibleSpace: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                _menuDrawer(),
                SizedBox(height: 20)
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
                  child: Text(_controller.categories[index] ?? ''),
                );
              }),
            ),
          ),
        ),
        body: TabBarView(
          children: _controller.categories.map((String category) {
            return Container();
            // return FutureBuilder(
            //   future: _controller.getProducts(category.id),
            //   builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            //     if (snapshot.hasData) {
            //       if (snapshot.data.length > 0) {
            //         return GridView.builder(
            //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2,
            //             childAspectRatio: 0.8,
            //           ),
            //           itemCount: snapshot?.data?.length ?? 0,
            //           itemBuilder: (_, index) {
            //             Product product = snapshot?.data[index];
            //             return _cardProduct(product);
            //           },
            //         );
            //       } else {
            //         return NoDataWidget(
            //           text: "Não há produtos",
            //         );
            //       }
            //     } else {
            //       return NoDataWidget(
            //         text: "Não há produtos",
            //       );
            //     }
            //   },
            // );
          }).toList(),
        ),
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
            onTap: _controller.goToProductCreate,
            title: Text("Criar producto"),
            trailing: Icon(Icons.local_pizza),
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
