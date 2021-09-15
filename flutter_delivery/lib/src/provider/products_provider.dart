import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/api/environment.dart';
import 'package:flutter_delivery/src/models/product.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class ProductsProvider {
  String _url = Environment.API_DELIVERY;

  String _api = '/api/products';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<Stream> create(Product product, List<File> images) async {
    try {
      Uri url = Uri.http(_url, "$_api/create");
      final request = http.MultipartRequest('POST', url);
      request.headers["Authorization"] = sessionUser.sessionToken;

      for (int i = 0; i < images.length; i++) {
        request.files.add(http.MultipartFile(
            'image',
            http.ByteStream(images[i].openRead().cast()),
            await images[i].length(),
            filename: basename(images[i].path)));
      }

      request.fields['product'] = json.encode(product);

      final response = await request.send(); //Enviar requisicao
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }
}
