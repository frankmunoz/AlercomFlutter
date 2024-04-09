
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
import 'package:alercom/src/services/services.dart';

import 'package:sqflite/sqflite.dart';

  class AuthService extends ChangeNotifier{
  final String _host = Globals.host;
  String _endpoint = '';
  final String djangoToken = '';
  final storage = new FlutterSecureStorage();
  late Map<String, dynamic> profileValues ={};
  List<Map<String, dynamic>> _items = [];

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
      'role': 2
    };


    final url = Uri.https(_host, _endpoint);

    var encodeData = json.encode(authData);
    http.Response response = await http.post(
      url,
      body: encodeData,
      headers:  <String, String>{
        HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
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
  }


  Future<String?> login(
      context,
      String username,
      String password
  ) async{
    _endpoint = '/api/v1/login';
    RequestService service = new RequestService();
    final Map<String, dynamic> authData = {
      'username': username,
      'password': password
    };
    var encodeData = json.encode(authData);
    http.Response response = await service.post(_endpoint, encodeData);

    try{
      final Map<String,dynamic> decodedData = json.decode(utf8.decode(response.bodyBytes));
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Alercom da la bienvenida",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0
        );
        await loadSessionData(decodedData);

        return 'success';
      }else{
        String messageError = decodedData.toString();
        switch(decodedData.toString()){
          case '{detail: Token inválido.}':
            messageError = 'Token inválido';
            break;
          case '{Error: 121}':
            messageError = 'Revise los datos ingresados';
            break;
        }
        NotificationUI.notify(context: context, title: 'Error', message: messageError);
        print("Error: " + response.statusCode.toString());
        print("Error: " + decodedData.toString());
        return 'failed';
      }

    } catch (e) {
      NotificationUI.notify(context: context, title: 'Error', message: 'Error creando usuario: ' + e.toString());
      print("FALLO2 $e");
      return 'failed';
    }

  }
  Future<String?> loginAnonymous( context ) async {
    _endpoint = '/api/v1/login';
    RequestService service = new RequestService();
    final Map<String, dynamic> authData = {
      'is_anonymous': true
    };
    var encodeData = json.encode(authData);
    http.Response response = await service.post(_endpoint, encodeData);

    try{
      final Map<String,dynamic> decodedData = json.decode(utf8.decode(response.bodyBytes));
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
        await loadSessionData(decodedData);
        return 'success';
      } else {
        String messageError = decodedData.toString();
        NotificationUI.notify(context: context, title: 'Error', message: messageError);
        print("Error: " + response.statusCode.toString());
        print("Error: " + decodedData.toString());
        return 'failed';
      }
    } catch (e) {
      NotificationUI.notify(context: context, title: 'Error', message: 'Error creando usuario: ' + e.toString());
      print("FALLO2 $e");
      return 'failed';
    }
  }

  Future<void> loadSessionData(Map<String, dynamic> decodedData) async {
    storage.write(key: 'token', value: decodedData['token']);
    storage.write(key: 'userId', value: decodedData['user_id'].toString());
    storage.write(key: 'email', value: decodedData['email']);
    storage.write(key: 'username', value: decodedData['username']);
    storage.write(key: 'firstName', value: decodedData['first_name']);
    storage.write(key: 'lastName', value: decodedData['last_name']);
    storage.write(key: 'location', value: decodedData['location'].toString());
    storage.write(key: 'role', value: decodedData['role'].toString());
    storage.write(key: 'isAnonymous', value: "false");
  }


  Future logout() async{
    _endpoint = '/rest-auth/logout/';
    RequestService service = new RequestService();
    var headers =  <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': await storage.read(key: 'token') ?? '',
    };
    var encodeData = json.encode(headers);
    http.Response response = await service.post(_endpoint, encodeData);
    await storage.delete(key: 'token');
    await storage.deleteAll();
    try {
      String data = utf8.decode(response.bodyBytes);
      final Map<String,dynamic> decodedData = json.decode(data);
      if (response.statusCode == 200) {
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
        await storage.delete(key: 'user');
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


  Future logoutOLD() async{
    _endpoint = '/rest-auth/logout/';
    final url = Uri.https(_host, _endpoint);
    var headers =  <String, String>{
      HttpHeaders.contentTypeHeader: 'application/json',
      'Authorization': await storage.read(key: 'token') ?? '',
    };


    await storage.delete(key: 'token');
    await storage.deleteAll();

    http.Response response = await http.post(
        url,
        headers: headers,
        encoding: Encoding.getByName("utf-8")
    );

    try {
      String data = utf8.decode(response.bodyBytes);
      final Map<String,dynamic> decodedData = json.decode(data);
      if (response.statusCode == 200) {
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
        await storage.delete(key: 'user');
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


  Future<String> readToken() async {

    return await storage.read(key: 'token') ?? '';

  }


  Future<String> getStorageKey(String key) async{
    return await SecureStorage.getStorageKey(key) ?? '';
  }

//TODO: Utilizar este método para profile
  Future<String?> getAllStorageKey() async {
      Map<String, String> allValues = await storage.readAll();
  }

  void addItem(Map<String, dynamic> item) {
    _items.add(item);
  }

  Future<String> retrievingData(key) async {
    final storage = new FlutterSecureStorage();
    Map<String, String> allValues = await storage.readAll();
    allValues.forEach((key, value) {
      Map<String, dynamic> profileValues = {'value': value, 'key': key};
      addItem(profileValues);
    });
    profileValues.forEach((k,v) => print("got key $k with $v"));

    return await SecureStorage.getStorageKey(key) ?? '';
  }

  List<Map<String, dynamic>> getProfileValues()=>_items;

  String getProfileValuesByKey(String key){
    String found= '';
    _items.forEach((element) {
      if(element['key'] == key) {
        found = element['value'];
      }
    });
    return found;
  }

}