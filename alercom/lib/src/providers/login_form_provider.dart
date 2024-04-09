import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  String email = '';
  String password = '';
  String username = '';
  String first_name = '';
  String last_name = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading( bool value ){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm(){
    return loginFormKey.currentState?.validate() ?? false;
  }

}