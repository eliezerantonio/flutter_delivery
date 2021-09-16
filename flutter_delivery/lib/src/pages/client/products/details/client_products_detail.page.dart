import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/details/client_products_detail_contreoller.dart';
import 'package:flutter_delivery/src/utils/my_colors.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ClientProductsDetailPage extends StatefulWidget {
  Product product;
  ClientProductsDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  _ClientProductsDetailPageState createState() =>
      _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {
  ClientProductsDetailController _controller =
      new ClientProductsDetailController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _imageSlideShow(),
          _textName(),
          SizedBox(height: 7),
          _textDescription(),
          Spacer(),
          _addOrRemoveItem(),
          _standartDelivery(),
          _buttonShopingBag()
        ],
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(_controller.product?.name ?? " ",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        _controller.product?.description ?? " ",
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _addOrRemoveItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        children: [
          IconButton(
            onPressed: _controller.addItem,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Text(
            "${_controller.counter}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          IconButton(
            onPressed: _controller.removeItem,
            icon: Icon(
              Icons.remove_circle_outline,
              color: Colors.grey,
              size: 30,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              "${_controller.productPrice ?? 0} KZ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _standartDelivery() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: [
            Image.asset(
              "assets/img/delivery.png",
              height: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Frete padrão", style: TextStyle(color: Colors.green))
          ],
        ));
  }

  Widget _buttonShopingBag() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
      child: ElevatedButton(
        onPressed: _controller.addToBag,
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
                height: 44,
                alignment: Alignment.center,
                child: Text("Adicionar ao carrinho",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 70, top: 7),
                child: Image.asset(
                  "assets/img/bag.png",
                  height: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageSlideShow() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          child: ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            initialPage: 0,
            indicatorColor: Colors.red,
            indicatorBackgroundColor: Colors.grey,
            children: [
              FadeInImage(
                image: widget.product?.image1 != null
                    ? NetworkImage(
                        widget.product?.image1,
                      )
                    : AssetImage("assets/img/no-image.png"),
                fit: BoxFit.contain,
                placeholder: AssetImage("assets/img/no-image.png"),
                fadeInDuration: Duration(seconds: 3),
              ),
              FadeInImage(
                image: widget.product?.image2 != null
                    ? NetworkImage(
                        widget.product?.image2,
                      )
                    : AssetImage("assets/img/no-image.png"),
                fit: BoxFit.contain,
                placeholder: AssetImage("assets/img/no-image.png"),
                fadeInDuration: Duration(seconds: 3),
              ),
              FadeInImage(
                image: widget.product?.image3 != null
                    ? NetworkImage(
                        widget.product?.image3,
                      )
                    : AssetImage("assets/img/no-image.png"),
                fit: BoxFit.contain,
                placeholder: AssetImage("assets/img/no-image.png"),
                fadeInDuration: Duration(seconds: 3),
              )
            ],
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 3000,
          ),
        ),
        Positioned(
          left: 10,
          top: 5,
          child: IconButton(
            splashColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(Icons.arrow_back_ios, color: MyColors.primaryColor),
          ),
        )
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
