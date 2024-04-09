
import 'package:alercom/src/services/request_service.dart';
import 'package:alercom/src/utils/secure_storage_util.dart';
import 'package:alercom/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:alercom/src/ui/notification_ui.dart';
import 'dart:typed_data';

class MarkService extends ChangeNotifier{
  final String _host = Globals.host;
  String _endpoint = '';
  final String djangoToken = '';
  final storage = new FlutterSecureStorage();

  Future<String?> createMark(
      context,
      int person,
      int category,
      int location,
      String name,
      String whenHappend,
      String whereHappend,
      String affectedsRange,
      String? affectedTo,
      String? observations,
      String? lat,
      String? lon,
      String? photo,
      ) async{
    _endpoint = '/api/v1/marks/';
    RequestService service = new RequestService();
    final Map<String, dynamic> markData = {
      "person": person,
      "location":location,
      "category": category,
      "name": name,
      "when_happend": whenHappend,
      "where_happend": whereHappend,
      "affecteds_range": affectedsRange,
      "affected_to": affectedTo,
      "observations": observations,
      "lat": "1.0000000",
      "lon": "1.0000000",
      "photo": "pic1.jpg",
      "active": 1
    };
    var encodeData = json.encode(markData);
    http.Response response = await service.post(_endpoint, encodeData);

    try {
      final Map<String,dynamic> decodedData = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 201) {
        print(decodedData);
        Fluttertoast.showToast(
            msg: "Su reporte fue enviado satisfactoriamente a la entidad correspondiente",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return 'success';
      } else {
        String messageError = decodedData.toString();

        NotificationUI.notify(context: context, title: 'Error', message: messageError);
        print("Error: " + response.statusCode.toString());
        print("Error: " + decodedData.toString());
        return 'failed';
      }
    } catch (e) {
      NotificationUI.notify(context: context, title: 'Error', message: 'Error creando registro' + e.toString());
      print("FALLO2 $e");
      return 'failed';
    }
  }

}