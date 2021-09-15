import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  String text;
  NoDataWidget({this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/img/no_items.png"),
            Text(text),
          ],
        ));
  }
}
