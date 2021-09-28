// To parse this JSON data, do
//
//     final responseApi = responseApiFromJson(jsonString);

import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  ResponseApi({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  bool success;
  String error;
  String message;
  dynamic data;

  ResponseApi.fromJson(Map<String, dynamic> json) {
    success = json["success"];
    message = json["message"];
    error = json["error"];

    try {
      data = json["data"];
    } catch (e) {
      print("Exception data $e");
    }
  }
  Map<String, dynamic> toJson() =>
      {"success": success, "message": message, "error": error, "data": data};


      
}
