import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/login/login_page.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

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
      },
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
      ),
    );
  }
}
