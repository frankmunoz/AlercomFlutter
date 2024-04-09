import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alercom/src/services/auth_service.dart';
import 'package:alercom/src/screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.getToken(),
          builder: (BuildContext context, AsyncSnapshot<String> shapshot){
            if(!shapshot.hasData)
              return Text('Solo un momento más');
            if(shapshot.hasData == '') {
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
                    pageBuilder: (_,__,___) =>  MapScreen(),
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
