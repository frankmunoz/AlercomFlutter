import 'package:flutter/material.dart';
import 'package:alercom/src/pages/components/alert_page.dart';

import 'package:alercom/src/pages/components/avatar_page.dart';
import 'package:alercom/src/pages/home_page.dart';
import 'package:alercom/src/pages/components/card_page.dart';
import 'package:alercom/src/pages/components/animated_container.dart';
import 'package:alercom/src/pages/input_page.dart';
import 'package:alercom/src/screens/screens.dart';

//import 'package:alercom/src/screens/gmap/place_tracker_app.dart';

Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeScreen(),
    'register': (BuildContext context) => RegisterScreen(),
    'login': (BuildContext context) => LoginScreen(),
    'home': (BuildContext context) => HomeScreen(),
    'checking': (BuildContext context) => CheckAuthScreen(),
    'institutionalRoutes': (BuildContext context) => InstitutionalRoutesScreen(),
    'profile': (BuildContext context) => ProfileScreen(),
    'security': (BuildContext context) => SecurityScreen(),
    'parse': (BuildContext context) => ParseJsonScreen(),

    'migration': (BuildContext context) => MigrationScreen(),
    'vbg': (BuildContext context) => VBGScreen(),
    'victims': (BuildContext context) => VictimsScreen(),
    'child': (BuildContext context) => ChildScreen(),
    'mind_health': (BuildContext context) => MindHealthScreen(),

    'place': (BuildContext context) => CategoryScreen(),
    'place_edit': (BuildContext context) => MarkScreen(),
    'location': (BuildContext context) => LocationScreen(),

    'report_alercom': (BuildContext context) => ReportScreen(),
    'report_detail': (BuildContext context) => ReportDetailScreen(),

    'protection': (BuildContext context) => ContentScreen(),
    'useOfAlercom': (BuildContext context) => UseOfAlercomScreen(),


    'alert': (BuildContext context) => InputPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputPage(),
  };
}

