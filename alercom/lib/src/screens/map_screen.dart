import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
//import 'package:alercom/src/utils/utils.dart';

import 'package:alercom/src/services/services.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreeenState createState() => _MapScreeenState();
}

 class _MapScreeenState extends  State<MapScreen>{
  final center = LatLng(4.816179, -74.070894);
  final mapDarkStyle = 'mapbox://styles/frankflutter/cksjimbe63vac17pe97nt66x1';
  final mapDefaultStyle = 'mapbox://styles/frankflutter/cksjorqww1nyv18qxa2dwwb3s';
  String mapSelectedStyle = 'mapbox://styles/frankflutter/cksjorqww1nyv18qxa2dwwb3s';
  late MapboxMapController mapController;
  Color backgroundColor = Color.fromRGBO(148, 32, 131, 1);
  Color fontColor = Color.fromRGBO(255, 192, 1, 1);


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Alercom',
            style: TextStyle(color: fontColor),
          ),
          elevation: 2.0,
          backgroundColor: backgroundColor,
          actions: [IconButton(
            icon: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.login_outlined),
            ),
            onPressed: (){
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),]
      ),
      body: buildMapboxMap(mapDarkStyle, center),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Column buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Symbol
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.add_alert),
            ),
            backgroundColor: backgroundColor,
            onPressed: (){
              mapController.addSymbol(SymbolOptions(
                geometry: center,
                iconImage: 'assetImage',
                iconSize: 3,
                textOffset: Offset(0,2),
                textField: 'punto de alerta',
                textColor: '#000000'
              ));
            }
        ),
        SizedBox( height: 5,),
        // ZoomIn
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.zoom_in),
            ),
            backgroundColor: backgroundColor,
            onPressed: (){
              mapController.animateCamera( CameraUpdate.zoomIn());
            }
        ),
        SizedBox( height: 5,),

        // ZoomOut
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.zoom_out),
            ),
            backgroundColor: backgroundColor,
            onPressed: (){
              mapController.animateCamera( CameraUpdate.zoomOut());
            }
        ),
        SizedBox( height: 5,),

        // Change Map Style
        FloatingActionButton(
          child: new IconTheme(
            data: new IconThemeData(
                color:  fontColor
            ),
            child: new Icon(mapSelectedStyle==mapDarkStyle?Icons.wb_sunny:Icons.nightlight_round),
          ),
          backgroundColor: backgroundColor,

          onPressed: (){
            if (mapSelectedStyle  == mapDarkStyle){
              mapSelectedStyle = mapDefaultStyle;
            }else{
              mapSelectedStyle = mapDarkStyle;
            }
            setState((){});
          }
        )
      ],
    );
  }

  MapboxMap buildMapboxMap(String mapStyleDark, LatLng center) {
    return MapboxMap(
      //accessToken: ,
      styleString: mapSelectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
        CameraPosition(
          zoom: 16,
          target: center,
        ),
    );
  }


  Future<void> _onMapCreated(MapboxMapController controller) async {
    mapController = controller;
/*
    final result = await acquireCurrentLocation();
    await controller.animateCamera(
      CameraUpdate.newLatLng(result),
    );

    // Add a circle denoting current user location
    await controller.addCircle(
      CircleOptions(
        circleRadius: 8.0,
        circleColor: '#006992',
        circleOpacity: 0.8,

        // YOU NEED TO PROVIDE THIS FIELD!!!
        // Otherwise, you'll get a silent exception somewhere in the stack
        // trace, but the parameter is never marked as @required, so you'll
        // never know unless you check the stack trace
        geometry: result,
        draggable: false,
      ),
    );
*/
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/symbols/custom-icon.png");
    addImageFromUrl("networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController.addImage(name, response.bodyBytes);
  }




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
  /*
   @override
   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
     super.debugFillProperties(properties);
     properties.add(StringProperty('mapStyleDefault', mapStyleDefault));
   }
   */
}
