// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/ui/ui.dart';
import 'package:alercom/src/utils/utils.dart';

import 'screens.dart';

class HomeScreen extends StatefulWidget {
  final LatLng? center;

  const HomeScreen({
    Key? key,
    this.center,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends  State<HomeScreen>{
  Color backgroundColor =  Globals.backgroundColor;
  Color backgroundColorLite = Globals.backgroundColorLite;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(authService),
      body: buildBody(authService),
    );
  }
  Center buildBody(AuthService authService) {
    return Center(
      child: FutureBuilder(
        future: authService.retrievingData('role'),
        builder: (BuildContext context, AsyncSnapshot<String> shapshot){
          return buildContainer(shapshot, authService);
        }
      )
    );
  }
  Container buildContainer(AsyncSnapshot<String> shapshot, AuthService authService){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 12;
    final double itemWidth = size.width / 2;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.white,
              Colors.white,
            ],
          )
      ),
      padding: EdgeInsets.all(20.0),
      child: GridView.count(
        crossAxisCount:1,
        childAspectRatio: (itemWidth / itemHeight),
        children: <Widget>[
          ButtonUI(
            title: "Mi perfil",
            icon: Icons.person,
            image:'assets/icons/profile.png',
            withIcon:false,
            bgColor: backgroundColor,
            fontColor:Colors.white,
            onTapAction: (){ Navigator.pushNamed(context, 'profile');},
          ),
          ButtonUI(
              title: "Yo reporto" ,
              icon: Icons.security_update_good_outlined,
              image: Globals.reportIcon,
              withIcon:false,
              bgColor: backgroundColor,
              fontColor:Colors.white,
              onTapAction: (){ Navigator.pushNamed(context, 'place'); }
          ),
          ButtonUI(
              title: "Rutas institucionales",
              icon: Icons.account_balance_outlined,
              image: Globals.institutionalIcon,
              withIcon:false,
              bgColor: backgroundColor,
              fontColor:Colors.white,
              onTapAction: (){ Navigator.pushNamed(context, 'institutionalRoutes'); }
          ),
          ButtonUI(
              title: "Protección de datos",
              icon: Icons.work_rounded,
              image: Globals.dataProtectionIcon,
              withIcon:false,
              bgColor: backgroundColor,
              fontColor:Colors.white,
              onTapAction: (){ Navigator.pushNamed(context, 'protection'); }
          ),
          ButtonUI(
              title: "Uso Alercom",
              icon: Icons.book,
              image: Globals.useAlercomIcon,
              withIcon:false,
              bgColor: backgroundColor,
              fontColor:Colors.white,
                onTapAction: (){ Navigator.pushNamed(context, 'useOfAlercom'); }
          ),
          if(shapshot.data.toString() == "1") //Expert Profile can view this
            ButtonUI(
                title: "Ver reportes",
                icon: Icons.book,
                image: Globals.marksIcon,
                withIcon:false,
                bgColor: backgroundColor,
                fontColor:Colors.white,
                onTapAction: (){ Navigator.pushNamed(context, 'report_alercom'); }

            ),

        ],
      ),
    );
  }

  PreferredSize buildAppBar(authService){
    return PreferredSize(
      preferredSize: Size.fromHeight(Globals.appBarHeight),
      child: AppBar(
        iconTheme: IconThemeData(color: fontColor),
//        title: Image.asset('assets/icon.png', fit: BoxFit.cover, height: 60,),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            Image.asset('assets/icon.png', fit: BoxFit.cover, height: 60,),
            Text(
                'Alercom', //+  await storage.read(key: 'token') ?? '' ,
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
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: GestureDetector(
              child:  Text(
                  '\nSalir', // + SecureStorage.getStorageKey('token').toString(),//+  await storage.read(key: 'token') ?? '' ,
                  style: TextStyle(color: fontColor)
              ),
              onTap: () {
                Navigator.pushReplacementNamed(context, 'login');
              },
            ),
          )
        ],
/*
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
*/

      ),
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
}


