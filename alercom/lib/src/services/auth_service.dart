import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:alercom/src/ui/notification_ui.dart';

class AuthService extends ChangeNotifier{
  final String _baseUrl = 'http://192.168.0.7:8000';
  String _endpoint = '';
  final String djangoToken = '';
  final storage = new FlutterSecureStorage();

  Future<String?> createUser( context, String email, String password, String username ) async{
    _endpoint = '/api/v1/persons/';
    print('Email: $email Pass: $password');
    final Map<String, dynamic> authData = {
      'user': {
        'username': username,
        'email': email,
        'first_name': '',
        'last_name': '',
        'password1': password,
        'password2': password
      },
      'partner':1,
      'role': 1
    };


//    var url = Uri.parse('$_baseUrl$_endpoint');
    var url = Uri.parse('$_baseUrl$_endpoint');
    var encodeData = json.encode(authData);
    http.Response response = await http.post(
      url,
      body: encodeData,
      headers:  <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    try {
      print(encodeData);
      String data = response.body;
      final Map<String,dynamic> decodedData = json.decode(data);// jsonDecode(data);
      if (response.statusCode == 201) {
        print(decodedData);
        Fluttertoast.showToast(
            msg: "Usuario creado satisfactoriamente, debes revisar tu correo con las instrucciones para continuar",
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
          case '{Error: 100}':
            messageError = 'Las contraseñas no coinciden  ';
            break;
          case '{Error: 101}':
            messageError = 'La dirección de correo electrónico no es válida';
            break;
          case '{Error: 102}':
            messageError = 'Ya existe un usuario con esa dirección de correo electrónico';
            break;
          case '{Error: 103}':
            messageError = 'La contraseña debe tener al menos 8 caracteres';
            break;
          case '{Error: 104}':
            messageError = 'La contraseña debe tener al menos 1 dígito';
            break;
          case '{Error: 105}':
            messageError = 'La contraseña debe tener al menos una letra';
            break;
          case '{Error: 106}':
            messageError = 'Esta contraseña es demasiado común';
            break;
          case '{Error: 107}':
            messageError = 'El nomnbre de usuario no puede estar en blanco';
            break;
          case '{Error: 110}':
            messageError = 'Ya existe un usuario con este nombre';
            break;
          case '{Error: 111}':
            messageError = 'El nombre de usuario solo puede tener caracteres alfanuméricos, guión bajo o punto';
            break;
          case '{Error: 112}':
            messageError = 'El nombre de usuario es demasiado corto, debe tener al menos 5 caracteres';
            break;
          case '{Error: 119}':
            messageError = 'Nombre no puede ser vacío';
            break;
          case '{Error: 120}':
            messageError = 'Apellido no puede ser vacío';
            break;
          case '{Error: 121}':
            messageError = 'Error en la petición';
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



    /*

    var url = Uri.parse('$_baseUrl$_endpoint' );
    print('URL=>$url');
    final response = await http.post(url, body: json.encode(authData));
    final Map<String,dynamic> decodedResponse = json.decode( response.body );

    print(decodedResponse);

*/
  }


  Future<String?> login( context, String username, String password ) async{
    _endpoint = '/rest-auth/login/';
    print('Username: $username Pass: $password');
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };


//    var url = Uri.parse('$_baseUrl$_endpoint');
    var url = Uri.parse('$_baseUrl$_endpoint');
    var encodeData = json.encode(authData);
    http.Response response = await http.post(
        url,
        body: encodeData,
        headers:  <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    try {
      print(encodeData);
      String data = response.body;
      final Map<String,dynamic> decodedData = json.decode(data);// jsonDecode(data);
      if (response.statusCode == 200) {
        print(decodedData);
        Fluttertoast.showToast(
            msg: "Alercom da la bienvenida",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0
        );
        print(decodedData['key']);
        await storage.write(key: 'token', value: decodedData['key']);
        return 'success';
      } else {
        String messageError = decodedData.toString();
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


  Future logout() async{
    _endpoint = '/rest-auth/logout/';
    var url = Uri.parse('$_baseUrl$_endpoint');
   // var encodeData = json.encode({});
    http.Response response = await http.post(
        url,
       // body: encodeData,
        headers:  <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': getToken().toString()
        }
    );

    try {
      String data = response.body;
      final Map<String,dynamic> decodedData = json.decode(data);// jsonDecode(data);

      if (response.statusCode == 200) {
        print(decodedData);
        Fluttertoast.showToast(
            msg: decodedData['detail'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0
        );
        await storage.delete(key: 'token');
      }else{
        print(decodedData);
        Fluttertoast.showToast(
            msg: 'Error cerrando sesión',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.deepPurple,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Error cerrando sesión $e',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    return;
  }


  Future<String> getToken() async{
    return await storage.read(key: 'token') ?? '';

  }

}