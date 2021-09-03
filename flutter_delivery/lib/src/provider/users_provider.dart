import 'package:flutter/material.dart';
import 'package:flutter_delivery/src/api/environment.dart';
import 'package:flutter_delivery/src/models/user.dart';

class UsersProvider {
  String _url = Environment.API_DELIVERY;
  String _api = '/api/users';

  late BuildContext context;

  Future? initState(BuildContext context) {
    this.context = context;
  }

  Future<ResponseApi> create(User user){
    
  }
}
