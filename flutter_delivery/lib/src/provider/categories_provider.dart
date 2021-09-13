
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/api/environment.dart';
import 'package:flutter_delivery/src/models/category.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';

class CategoriesProvider {
  String _url = Environment.API_DELIVERY;

  String _api = '/api/categories';

  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, "$_api/create");
      String bodyParams = json.encode(category);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.post(url, headers: headers, body: bodyParams);

      final data = json.decode(response.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);

      return responseApi;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
