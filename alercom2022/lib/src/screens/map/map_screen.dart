// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
//import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:provider/provider.dart';
import 'package:alercom/src/utils/utils.dart';

import 'dart:async';
import 'dart:typed_data';

import 'package:alercom/src/services/services.dart';
/*
import 'gmap/place.dart';
import 'gmap/place_list.dart';
import 'gmap/place_map.dart';
import 'gmap/place_tracker_app.dart';
import 'gmap/stub_data.dart';
*/

class MapScreen extends StatefulWidget {
  final LatLng? center;

  const MapScreen({
    Key? key,
    this.center,
  }) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}



class _MapScreenState extends  State<MapScreen>{
  final center = LatLng(4.816179, -74.070894);
  final lat = 4.816179;
  final lng = -74.070894;
  final mapDarkStyle = 'mapbox://styles/frankflutter/cksjimbe63vac17pe97nt66x1';
  final mapDefaultStyle = 'mapbox://styles/frankflutter/cksjorqww1nyv18qxa2dwwb3s';
  String mapSelectedStyle = 'mapbox://styles/frankflutter/cksjorqww1nyv18qxa2dwwb3s';
  //late MapboxMapController mapController;
  Completer<GoogleMapController> mapController = Completer();
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  MapType _currentMapType = MapType.normal;
  final Set<Marker> _markers = {};
  LatLng? _lastMapPosition;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );
   // final state = Provider.of<AppState>(context, listen: false);
    var user = authService.getStorageKey('username').toString();
    return Scaffold(
      appBar: buildAppBar(authService),
      body: buildGoogleMap(mapDarkStyle, center),
      floatingActionButton: buildFloatingActionButton(),
      drawer: buildDrawer(authService),
    );
  }

  AppBar buildAppBar(authService){
    return AppBar(
        iconTheme: IconThemeData(color: fontColor),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Text(
                'Alercom',
                style: TextStyle(color: fontColor)
            )
          ],
        ),

        elevation: 2.0,
        backgroundColor: backgroundColor,

        actions: [IconButton(
          icon: new IconTheme(
            data: new IconThemeData(
                color:  fontColor
            ),
            child: new Icon(Icons.map),
          ),
          onPressed: (){
//            authService.logout();
//            Navigator.pushReplacementNamed(context, 'login');
          },
        ),]


    );
  }


  Drawer buildDrawer(authService){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children:  <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Text(
              'Alercom ' + authService.getUser().toString() ,
              style: TextStyle(
                color: fontColor,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_outlined),
            title: Text('Rutas Institucionales'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.pushNamed(context, 'institutionalRoutes');
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Perfil'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.pushNamed(context, 'profile');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Seguridad'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              Navigator.pushNamed(context, 'security');
            },
          ),
          ListTile(
            leading: Icon(Icons.login_outlined),
            title: Text('Salir'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: (){
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
      ),
    );
  }

  Column buildFloatingActionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // Symbol
        SizedBox( height: 100,),
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.add_alert),
            ),
            backgroundColor: backgroundColor,
            onPressed: (){
/*              mapController.addSymbol(SymbolOptions(
                geometry: center,
                iconImage: 'assetImage',
                iconSize: 3,
                textOffset: Offset(0,2),
                textField: 'punto de alerta',
                textColor: '#000000'
              ));*/
            }
        ),
        SizedBox( height: 5,),
        // ZoomIn
        FloatingActionButton(
            child: new IconTheme(
              data: new IconThemeData(
                  color:  fontColor
              ),
              child: new Icon(Icons.location_on),
            ),
            backgroundColor: backgroundColor,
            onPressed: (){}
        ),
        SizedBox( height: 5,),

        // Change Map Style
        FloatingActionButton(
          child: new IconTheme(
            data: new IconThemeData(
                color:  fontColor
            ),
            child: new Icon(mapSelectedStyle==mapDarkStyle
                ? Icons.wb_sunny
                : Icons.nightlight_round
            ),
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


  /*MapboxMap buildMapboxMap(String mapStyleDark, LatLng center) {
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
  }*/

  GoogleMap buildGoogleMap(String mapStyleDark, LatLng center) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),

      mapType: _currentMapType,
      //markers: _markers,

      markers: Set<Marker>.of(
        <Marker>[
          Marker(
              onTap: () {
                print('Tapped');
              },
              draggable: true,
              markerId: MarkerId('Marker'),
              position: LatLng(lat, lng),
              onDragEnd: ((newPosition) {
                print(newPosition.latitude);
                print(newPosition.longitude);
              })
          )
          /*Marker(
            draggable: true,
            markerId: MarkerId("1"),
            position: LatLng(lat, lng),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: const InfoWindow(
              title: 'Usted está aquí',
            ),
          )*/
        ],
      ),
      onCameraMove: (position) => _lastMapPosition = position.target,
      myLocationEnabled: true,







    );
    /*

    return GoogleMap(
      //accessToken: ,
      //styleString: mapSelectedStyle,
      onMapCreated: _onMapCreated,
      initialCameraPosition:
      CameraPosition(
        zoom: 16,
        target: center,
      ),
    );
    */
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController.complete(controller);
    _lastMapPosition = widget.center;

    // Draw initial place markers on creation so that we have something
    // interesting to look at.
    var markers = <Marker>{};
/*    for (var place in Provider.of<AppState>(context, listen: false).places) {
      markers.add(await _createPlaceMarker(context, place));
    }
    setState(() {
      _markers.addAll(markers);
    });

    // Zoom to fit the initially selected place.
    _zoomToFitSelectedCategory()
    */
  }






/*
  /// Applies zoom to fit the places of the selected place
  void _zoomToFitSelectedCategory() {
    _zoomToFitPlaces(
      _getPlacesForCategory(
        Provider.of<AppState>(context, listen: false).selectedCategory,
        _markedPlaces.values.toList(),
      ),
    );
  }
  */


/*
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
*/
/*
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
*/



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



/*
class AppState extends ChangeNotifier {
  AppState({
    this.places = StubData.places,
    this.selectedCategory = PlaceCategory.security,
    this.viewType = PlaceTrackerViewType.map,
  });

  List<Place> places;
  PlaceCategory selectedCategory;
  PlaceTrackerViewType viewType;

  void setViewType(PlaceTrackerViewType viewType) {
    this.viewType = viewType;
    notifyListeners();
  }

  void setSelectedCategory(PlaceCategory newCategory) {
    selectedCategory = newCategory;
    notifyListeners();
  }

  void setPlaces(List<Place> newPlaces) {
    places = newPlaces;
    notifyListeners();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppState &&
        other.places == places &&
        other.selectedCategory == selectedCategory &&
        other.viewType == viewType;
  }

  @override
  int get hashCode => hashValues(places, selectedCategory, viewType);
}
*/
