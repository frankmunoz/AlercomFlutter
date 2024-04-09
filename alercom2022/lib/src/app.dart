import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:alercom/src/services/services.dart';

/*import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:alercom/src/routes/routes.dart';
import 'package:alercom/src/screens/screens.dart';
import 'package:provider/provider.dart';
*/

class AlercomState extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MultiProvider(
    /*  providers: [
        ChangeNotifierProvider(create: ( _ ) => ProfileService(), lazy: true ),
        ChangeNotifierProvider(create: ( _ ) => CategoryService(), lazy: true, ),
        ChangeNotifierProvider(create: ( _ ) => ContentService(), lazy: true, ),
        ChangeNotifierProvider(create: ( _ ) => SectionService(), lazy: true, ),
        ChangeNotifierProvider(create: ( _ ) => UseAlercomService(), lazy: true, ),
        ChangeNotifierProvider(create: ( _ ) => MarkService(), lazy: true, ),
        ChangeNotifierProvider(create: ( _ ) => ProductsService() ),
      ],*/
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService(),),
      ],
      child: AlercomStateBinding(),
    );
  }
}

class AlercomStateBinding extends StatelessWidget {
  @override
  Widget build(BuildContext context){
   // final authService = Provider.of<AuthService>(context);
   // String location = authService.getProfileValuesByKey('location');

    return MultiProvider(
      /*providers: [
        ChangeNotifierProvider(create: ( _ ) => ReportService(location), lazy: true ),
      ],*/
      providers: [],
      child: Alercom(),
    );

    return MultiProvider(
      providers: [],
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
      //  GlobalMaterialLocalizations.delegate,
       // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en','US'),
        const Locale('es','ES'),
      ],
      initialRoute: 'checking',
     // routes: getApplicationRoutes(),
      onGenerateRoute: ( RouteSettings settings ){
        print('RUUUTA CARDAS:  ${ settings.name }' );
        //return MaterialPageRoute(
       //     builder: ( BuildContext context) => LoginScreen()
        //);
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[300]
      ),
      //home: ContadorPage(),
    );
  }
}
