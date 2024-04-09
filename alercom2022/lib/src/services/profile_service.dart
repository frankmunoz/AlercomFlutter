import 'package:alercom/src/utils/secure_storage_util.dart';
import 'package:alercom/src/utils/singleton.dart';
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


class ProfileService extends ChangeNotifier {
  final String _host = Globals.host;
  String _endpoint = '';
  final String djangoToken = '';
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future<String?> getStorageKey(String key) async {
    final String value = await storage.read(key: key) ?? '';
    return value;
  }

  Future<String?> updateUser(context, String token, int user_id, String email, String username, String firstName, String lastName) async{
    _endpoint = '/api/v1/person/';
    final Map<String, dynamic> authData = {
    "user_id": user_id,
    "user_name": username,
    "email": email,
    "first_name": firstName,
    "last_name":  lastName
    };

    final url = Uri.https(_host, _endpoint);
    var encodeData = json.encode(authData);
    http.Response response = await http.put(
        url,
        body: encodeData,
        headers:  <String, String>{
          HttpHeaders.authorizationHeader: 'Token $token',
          HttpHeaders.acceptHeader: 'application/json; charset=UTF-8',
        }
    );
    try {
      print(encodeData);
      String data = response.body;
      final Map<String,dynamic> decodedData = json.decode(data);// jsonDecode(data);
      if (response.statusCode == 201) {
        print(decodedData);
        Fluttertoast.showToast(
            msg: "Tus datos han sido actualizados satisfactoriamente",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.purple,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return 'success';
      } else {
        String messageError = '';
        switch(decodedData.toString()){
          case '{Error: 1001}':
            messageError = 'Las contraseñas no coinciden  ';
            break;
          case '{Error: 1002}':
            messageError = 'La dirección de correo electrónico no es válida';
            break;

        }
        NotificationUI.notify(context: context, title: 'Error', message: messageError);
        print("Error: " + response.statusCode.toString());
        print("Error: " + decodedData.toString());
        return 'failed';
      }
    } catch (e) {
      NotificationUI.notify(context: context, title: 'Error', message: 'Error creando usuario' + e.toString());
      print("FALLO2 $e");
      return 'failed';
    }
  }
}