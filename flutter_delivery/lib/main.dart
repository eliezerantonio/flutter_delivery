import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/address/create/client_address_create_page.dart';
import 'package:flutter_delivery/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:flutter_delivery/src/pages/restaurant/list/restaurant_orders_list_page.dart';
import 'package:flutter_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:flutter_delivery/src/pages/roles/roles_page.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

import 'src/pages/client/address/list/client_address_list_page.dart';
import 'src/pages/client/address/map/client_address_map_page.dart';
import 'src/pages/client/update/client_update_page.dart';
import 'src/pages/login/login_page.dart';
import 'src/pages/register/register_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (_) => LoginPage(),
        'register': (_) => RegisterPage(),
        'roles': (_) => RolesPage(),
        'client/products/list': (_) => ClientProductsListPage(),
        'delivery/orders/list': (_) => DeliveryOrdersListPage(),
        'client/orders/create': (_) => ClientOrdersCreatePage(),
        'client/address/create': (_) => ClientAddressCreatePage(),
        'client/address/list': (_) => ClientAddressListPage(),
        'client/address/map': (_) => ClientAddressMapPage(),
        'restaurant/orders/list': (_) => RestaunrantOrdersListPage(),
        'restaurant/categories/create': (_) => RestaurantCategoriesPage(),
        'restaurant/products/create': (_) => RestaurantProductsCreatePage(),
        'client/update': (_) => ClientUpdatePage(),
      },
      theme: ThemeData(
          // fontFamily: 'NimbusSans',
          primaryColor: MyColors.primaryColor,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(elevation: 0)),
    );
  }
}
