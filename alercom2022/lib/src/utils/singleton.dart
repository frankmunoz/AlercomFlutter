class Singleton {
  static Singleton _singleton = Singleton._internal();
  //Constant constructor
  late int _userId;
  late String _name;
  late String _lastName;
  late String _email;
  late String _token;
  late String _username;
  String _contact = "Contacto";


  static Singleton get singleton => _singleton;

  static set singleton(Singleton value) {
    _singleton = value;
  }

  factory Singleton() {
    return _singleton;
  }
  Singleton._internal();

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get lastName => _lastName;

  set lastName(String value) {
    _lastName = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get contact => _contact;

  set contact(String value) {
    _contact = value;
  }
}


