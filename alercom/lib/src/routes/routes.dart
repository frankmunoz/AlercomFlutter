import 'package:alercom/src/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:alercom/src/pages/components/alert_page.dart';

import 'package:alercom/src/pages/components/avatar_page.dart';
import 'package:alercom/src/pages/home_page.dart';
import 'package:alercom/src/pages/components/card_page.dart';
import 'package:alercom/src/pages/components/animated_container.dart';
import 'package:alercom/src/pages/input_page.dart';
import 'package:alercom/src/screens/screens.dart';


Map<String, WidgetBuilder> getApplicationRoutes(){
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => MapScreen(),
    'register': (BuildContext context) => RegisterScreen(),
    'login': (BuildContext context) => LoginScreen(),
    'home': (BuildContext context) => MapScreen(),
    'checking': (BuildContext context) => CheckAuthScreen(),



    'alert': (BuildContext context) => AlertPage(),
    'avatar': (BuildContext context) => AvatarPage(),
    'card': (BuildContext context) => CardPage(),
    'animatedContainer': (BuildContext context) => AnimatedContainerPage(),
    'inputs': (BuildContext context) => InputPage(),
  };
}

