import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:alercom/src//services/services.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/providers/mark_form_provider.dart';
import 'package:alercom/src/ui/ui.dart';
import 'package:alercom/src/utils/utils.dart';


class LocationScreen extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _LocationScreen()
    );
  }
}

class _LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<_LocationScreen> {
  final storage = new FlutterSecureStorage();
  final String _baseUrl = Globals.host;
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  void initState() {
    _getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categoryService = Provider.of<CategoryService>(context);
    final category = categoryService.selectedCategory;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Image.asset('assets/icons/report.png', fit: BoxFit.cover, height: 50,),
            Text(
                category.name,
                style: TextStyle(color: fontColor)
            ),
          ],
        ),

        elevation: 2.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.topCenter,
              colors: <Color>[
                /*Colors.black54,
                Colors.black87,
                Colors.black,
                backgroundColorLite,*/
                Colors.transparent,
                backgroundColor,
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),

      /*
      AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Text(category.name ,style: TextStyle(color: fontColor)),
        elevation: 2.0,
        backgroundColor: backgroundColor,
      ),*/
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(bottom: 100, top: 100, left: 30, right: 30),
            child: Text(
              'Seleccione la ubicación donde ocurrió el '+ category.name.toLowerCase() + ' a reportar',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            ),
          ),
          //======================================================== DEPARTAMENTO

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: backgroundColor,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: _myState.isNotEmpty ? _myState : null,
                        iconSize: 30,
                        icon: Icon(Icons.arrow_drop_down, color: fontColor,),
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 16,
                        ),
                        hint: Text('Seleccione Departamento', style: TextStyle(color: fontColor),),
                        dropdownColor: backgroundColor,
                        onChanged: (String? newValue) {
                          setState(() {
                            _myState = newValue!;
                            _getCitiesList();
                            print(_myState);
                          });
                        },
                        items: statesList.map((item) {
                          //print(item['id']);
                          return new DropdownMenuItem(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),

          //======================================================== MUNICIPIO

          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            color: backgroundColor,
            margin: EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        value: _myCity.isNotEmpty ? _myCity : null,
                        iconSize: 30,
                        icon: Icon(Icons.arrow_drop_down, color: fontColor,),
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 16,
                        ),
                        hint: Text('Seleccione Municipio', style: TextStyle(color: fontColor),),
                        dropdownColor: backgroundColor,
                        onChanged: (String? newValue) {
                          setState(() {
                            _myCity = newValue!;
                            category.location = int.parse(newValue);
                            Navigator.pushNamed(context, 'place_edit');

                          });
                        },
                        items: citiesList.map((item) {
                          return new DropdownMenuItem<String>(
                            child: new Text(item['name']),
                            value: item['id'].toString(),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  //=============================================================================== Api Calling here
//CALLING STATE API HERE
// Get State information by API
  late List statesList = [];
  late String _myState = '';


  Future<String?> _getStateList() async {

    var token = await storage.read(key: 'token');

    var headers = {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final uri = Uri.https(_baseUrl, '/api/v1/geolocations/country/40/type/1');

    await http.get(
        uri,
        headers: headers
    ).then((response) {
      var data = json.decode(utf8.decode(response.bodyBytes));
        setState(() => statesList = data);
    });
  }

  // Get State information by API
  late List citiesList = [];
  late String _myCity = '';

  Future<String?> _getCitiesList() async {

    var token = await storage.read(key: 'token');
    var headers = {
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    final uri = Uri.https(_baseUrl, '/api/v1/geolocations/country/40/parent/'  + _myState );
    final response = await http.get(
        uri,
        headers: headers
    );

    await http.get(uri, headers: headers)
        .then((response) {
            var data = json.decode(utf8.decode(response.bodyBytes));
            citiesList = [];

            //print(data);
            setState(() => citiesList = data);
        }
      );
  }
}

/*
class LocationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final categoryService = Provider.of<CategoryService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => CategoryFormProvider( categoryService.selectedCategory ),
      child: _LocationScreenBody(categoryService: categoryService),
    );
  }
}

class _LocationScreenBody extends StatelessWidget {
  const _LocationScreenBody({
    Key? key,
    required this.categoryService,
  }) : super(key: key);

  final CategoryService categoryService;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color.fromRGBO(148, 32, 131, 1);
    Color fontColor = Color.fromRGBO(255, 192, 1, 1);

    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final place = categoryForm.place;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Text(place.name ,style: TextStyle(color: fontColor)),
        elevation: 2.0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProductForm(),

            SizedBox( height: 100 ),

          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: categoryService.isSaving
            ? CircularProgressIndicator( color: Colors.white )
            : Icon( Icons.save_outlined ),
        onPressed: categoryService.isSaving
            ? null
            : () async {

          if ( !categoryForm.isValidForm() ) return;
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final categoryForm = Provider.of<CategoryFormProvider>(context);
    final place = categoryForm.place;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10 ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: categoryForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              SizedBox( height: 10 ),

              TextFormField(
                initialValue: place.name,
                onChanged: ( value ) => place.name = value,
                validator: ( value ) {
                  if ( value == null || value.length < 1 )
                    return 'El nombre es obligatorio';
                },
                decoration: InputDecorationUI.authInputDecoration(
                    hintText: 'Nombre del producto',
                    labelText: 'Nombre:'
                ),
              ),

              SizedBox( height: 30 ),

              SizedBox( height: 30 )

            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only( bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0,5),
            blurRadius: 5
        )
      ]
  );
}

 */