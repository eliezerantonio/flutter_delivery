import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/api/environment.dart';
import 'package:flutter_delivery/src/models/response_api.dart';
import 'package:flutter_delivery/src/models/user.dart';
import 'package:path/path.dart';

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  BuildContext context;

  Future<void> initState(BuildContext context) async {
    this.context = context;
  }

  Future<Stream> createWithImage(User user, File image) async {
    try {
      Uri url = Uri.http(_url, "$_api/create");
      final request = http.MultipartRequest('POST', url);

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);

      final response = await request.send(); //Enviar peticion
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }

  Future<Stream> update(User user, File image) async {
    try {
      Uri url = Uri.http(_url, "$_api/update");
      final request = http.MultipartRequest('PUT', url);

      if (image != null) {
        request.files.add(http.MultipartFile('image',
            http.ByteStream(image.openRead().cast()), await image.length(),
            filename: basename(image.path)));
      }

      request.fields['user'] = json.encode(user);

      final response = await request.send(); //Enviar peticion
      return response.stream.transform(utf8.decoder);
    } catch (e) {
      print("Error $e");
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, "$_api/create");
      String bodyParams = json.encode(user);

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final response = await http.post(url, headers: headers, body: bodyParams);

      final data = json.decode(response.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);

      return responseApi;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});

      Map<String, String> headers = {'Content-Type': 'application/json'};

      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = new ResponseApi.fromJson(data);

      return responseApi;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  Future<User> getById(String id) async {
    try {
      Uri url = Uri.http(_url, "$_api/findById/$id");
      Map<String, String> headers = {'Content-Type': 'application/json'};
      final res = await http.get(
        url,
        headers: headers,
      );
      final data = json.decode(res.body);

      User user = User.fromJson(data);

      return user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }
}
