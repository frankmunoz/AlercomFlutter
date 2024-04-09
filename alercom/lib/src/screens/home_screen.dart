import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alercom/src/services/services.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );
    return Scaffold(
      appBar: AppBar(
        title: Text('Alercom'),
        actions: [IconButton(
          icon: Icon(Icons.login_outlined),
          onPressed: (){
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),]
      ),
      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}
