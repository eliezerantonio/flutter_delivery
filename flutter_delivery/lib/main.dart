import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/pages/client/products/list/client_products_list_page.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

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
        'client/products/list': (_) => ClientProductsListPage(),
      },
      theme: ThemeData(
        // fontFamily: 'NimbusSans',
        primaryColor: MyColors.primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}
