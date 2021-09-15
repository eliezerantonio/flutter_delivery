import 'dart:convert';
import 'package:flutter_delivery/src/utils/shared_prefs.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  Future init(BuildContext context, User sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async {
    try {
      Uri url = Uri.http(_url, "$_api/getall");

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sessao expierada');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(response.body);
      Category category = Category.fromJsonList(data);

      return category.toList;
    } catch (e) {
      print('Error:  $e');
      return [];
    }
  }

  Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, "$_api/create");
      String bodyParams = json.encode(category);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final response = await http.post(url, headers: headers, body: bodyParams);

      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sessao expierada');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(response.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);

      return responseApi;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
