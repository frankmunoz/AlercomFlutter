import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/screens/screens.dart';
import 'package:alercom/src/utils/utils.dart';

import '../map/map_screen.dart';

class CheckAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    print("AUTHSERV===>" + authService.readToken().toString());

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          //future:  SecureStorage.getStorageKey('token'),
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> shapshot){
            print("INIT");
            if(!shapshot.hasData)
              return Text('Solo un momento más');
            print("CHECKING SESSION");
            print(shapshot.data);
            if(shapshot.data == '') {
              Future.microtask((){
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_,__,___) =>  LoginScreen(),
                  transitionDuration: Duration( seconds: 0 )
                ));
                //Navigator.of(context).pushReplacementNamed('home');
              });
            }else{
              Future.microtask((){
                Navigator.pushReplacement(context, PageRouteBuilder(
                    pageBuilder: (_,__,___) =>  HomeScreen(),
                    transitionDuration: Duration( seconds: 0 )
                ));
                //Navigator.of(context).pushReplacementNamed('home');
              });
            }
            return Container();
          },
        ),
      ),
    );
  }
}
