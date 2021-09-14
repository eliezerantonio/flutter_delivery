import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:flutter_delivery/src/pages/restaurant/products/create/resturant_products_create_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';

class RestaurantProductsCreatePage extends StatefulWidget {
  @override
  _RestaurantProductsCreatePageState createState() =>
      _RestaurantProductsCreatePageState();
}

class _RestaurantProductsCreatePageState
    extends State<RestaurantProductsCreatePage> {
  RestaurantProductsCreateController controller =
      RestaurantProductsCreateController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova producto"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          _textFieldName(),
          _textFieldDescription(),
          _textFieldPrice(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _cardImage(null, 1),
              _cardImage(null, 2),
              _cardImage(null, 3),
            ],
          )
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _buttonCreate() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
      child: ElevatedButton(
        onPressed: controller.createProduct,
        child: Text("Criar produto"),
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        maxLength: 180,
        maxLines: 2,
        controller: controller.nameController,
        decoration: InputDecoration(
          hintText: 'Nome do produto',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          suffixIcon: Icon(
            Icons.list_alt,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      decoration: BoxDecoration(
        color: MyColors.primaryOpacityColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: 'Nome do produto',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          suffixIcon: Icon(
            Icons.monetization_on,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _cardImage(File imageFile, int numberFile) {
    return imageFile != null
        ? Card(
            elevation: 3,
            child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image.file(imageFile, fit: BoxFit.cover)),
          )
        : Card(
            elevation: 3,
            child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width * 0.26,
                child: Image.asset("assets/img/no-image.png")),
          );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 7),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: controller.descriptionController,
        maxLength: 225,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Descricao do produto',
          border: InputBorder.none,
          hintStyle: TextStyle(color: MyColors.primaryColorDark),
          suffixIcon: Icon(
            Icons.description_outlined,
            color: MyColors.primaryColor,
          ),
          contentPadding: EdgeInsets.all(25),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}
