import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/pages/client/products/details/client_products_detail_contreoller.dart';
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
        ],
      ),
    );
  }

  Widget _imageSlideShow() {
    return Container(
      margin: EdgeInsets.all(20),
      child: ImageSlideshow(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.4,
        initialPage: 0,
        indicatorColor: Colors.red,
        indicatorBackgroundColor: Colors.grey,
        children: [
          FadeInImage(
            image: widget.product.image1 != null
                ? NetworkImage(
                    widget.product.image1,
                  )
                : AssetImage("assets/img/no-image.png"),
            fit: BoxFit.contain,
            placeholder: AssetImage("assets/img/no-image.png"),
            fadeInDuration: Duration(seconds: 3),
          ),
          FadeInImage(
            image: widget.product.image2 != null
                ? NetworkImage(
                    widget.product.image2,
                  )
                : AssetImage("assets/img/no-image.png"),
            fit: BoxFit.contain,
            placeholder: AssetImage("assets/img/no-image.png"),
            fadeInDuration: Duration(seconds: 3),
          ),
          FadeInImage(
            image: widget.product.image3 != null
                ? NetworkImage(
                    widget.product.image3,
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
    );
  }

  void refresh() {
    setState(() {});
  }
}
