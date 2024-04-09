import 'package:flutter/material.dart';

class MarkFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  late int id;
  late int person=0;
  late int category=0;
  late int location=0;
  late String name='';
  late String whenHappend='';
  late String whereHappend='';
  late String affectedsRange='';
  String affectedTo='';
  String? observations='';
  String? lat='';
  String? lon='';
  String? photo='';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading( bool value ){
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

}