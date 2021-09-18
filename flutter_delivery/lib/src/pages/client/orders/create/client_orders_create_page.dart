import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/orders/create/client_orders_create_controller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';
import 'package:flutter_delivery/src/widgets/no_data_widget.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  ClientOrdersCreatePage({Key key}) : super(key: key);

  @override
  _ClientOrdersCreatePageState createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {
  ClientOrdersCreateController _con = new ClientOrdersCreateController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: _con.selectedProducts.length > 0
          ? ListView(
              children: _con.selectedProducts.map((Product product) {
                return _cardProduct(product);
              }).toList(),
            )
          : NoDataWidget(
              text: "Sem produtos no carrinho",
            ),
      bottomNavigationBar: Container(
          height: MediaQuery.of(context).size.height * 0.29,
          child: Column(
            children: [
              Divider(
                color: Colors.grey[400],
                endIndent: 30,
                indent: 30,
              ),
              _textTotalPrice(),
              _buttonShopingBag()
            ],
          )),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      child: Row(
        children: [
          _imageProduct(product),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              _addOrRemoveItem(product)
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _textPrice(product),
              _buttonDelete(product), //
            ],
          )
        ],
      ),
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Text(
            "Total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Spacer(),
          Text(
            "${_con.total.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonShopingBag() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: MyColors.primaryColor,
          padding: EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 40,
                alignment: Alignment.center,
                child: Text("Continuar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 80, top: 7),
                child: Icon(Icons.check_circle, color: Colors.green, size: 30),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _textPrice(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        "${(product.price * product.price).toStringAsFixed(2)}",
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }

  Container _imageProduct(Product product) {
    return Container(
      width: 90,
      height: 90,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(
                product.image1,
              )
            : AssetImage("assets/img/no-image.png"),
        fit: BoxFit.contain,
        placeholder: AssetImage("assets/img/no-image.png"),
        fadeInDuration: Duration(seconds: 3),
      ),
    );
  }

  Row _addOrRemoveItem(Product product) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _con.addItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              color: Colors.grey[200],
            ),
            child: Text("-"),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          color: Colors.grey[200],
          child: Text(
            '${product?.quantity ?? 0}',
          ),
        ),
        GestureDetector(
          onTap: () => _con.removeItem(product),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              color: Colors.grey[200],
            ),
            child: Text("+"),
          ),
        ),
      ],
    );
  }

  void refresh() {
    setState(() {});
  }

  Widget _buttonDelete(Product product) {
    return IconButton(
        onPressed: () => _con.deleteItem(product),
        icon: Icon(Icons.delete, color: MyColors.primaryColor));
  }
}
