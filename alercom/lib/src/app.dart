import 'package:alercom/src/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:alercom/src/routes/routes.dart';
import 'package:alercom/src/services/services.dart';

import 'package:alercom/src/pages/components/alert_page.dart';
import 'package:provider/provider.dart';


class AlercomState extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
      ],
      child: Alercom(),
    );
  }
}

class Alercom extends StatelessWidget{
  @override
  Widget build( context ){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en','US'),
        const Locale('es','ES'),
      ],
      initialRoute: 'checking',
      routes: getApplicationRoutes(),
      onGenerateRoute: ( RouteSettings settings ){
        print('RUUUTA CARDAS:  ${ settings.name }' );
        return MaterialPageRoute(
            builder: ( BuildContext context) => LoginScreen()
        );
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300]
      ),
      //home: ContadorPage(),
    );
  }
}
