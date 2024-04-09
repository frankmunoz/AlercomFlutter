
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:io';
import 'dart:convert';

import 'package:alercom/src/utils/globals_util.dart';

class RequestService extends ChangeNotifier {

  Future<http.Response> get(String endpoint) async {
    final String _host = Globals.host;
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var headers = {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
    final uri = Uri.https(_host, endpoint);

    final response = await http.get(uri, headers: headers);
    return response;
  }


  List<dynamic> getCollection(http.Response response) {
    if (response.statusCode == 200) {
      List<dynamic> categoriesList = json.decode(
          utf8.decode(response.bodyBytes)
      );
      return categoriesList;
    }else{
      return [];
    }
  }


  Future<http.Response> post(String endpoint, String body) async {
    final String _host = Globals.host;
    final storage = new FlutterSecureStorage();
    var token = await storage.read(key: 'token');
    var headers = {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
    };
    final uri = Uri.https(_host, endpoint);
    final response = await http.post(uri, body: body, headers: headers);
    return response;
  }

}