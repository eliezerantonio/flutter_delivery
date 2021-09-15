import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/category.dart';

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
          ),
          SizedBox(
            height: 20,
          ),
          _dropDownCategories(controller.categories)
        ],
      ),
      bottomNavigationBar: _buttonCreate(),
    );
  }

  Widget _buttonCreate() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
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

  Widget _dropDownCategories(List<Category> categories) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Material(
        elevation: 2,
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.search,
                    color: MyColors.primaryColor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Categorias",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                    underline: Container(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_drop_down_circle,
                        color: MyColors.primaryColor,
                      ),
                    ),
                    elevation: 3,
                    isExpanded: true,
                    hint: Text(
                      "Selecionar categoria",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    items: _dropDownItems(categories),
                    value: controller.idCategory,
                    onChanged: (option) {
                      setState(() {
                        controller.idCategory = option;
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _dropDownItems(List<Category> categories) {
    List<DropdownMenuItem<String>> list = [];

    categories.forEach((category) {
      list.add(
          DropdownMenuItem(child: Text(category.name), value: category.id));
    });

    return list;
  }

  void refresh() {
    setState(() {});
  }
}
