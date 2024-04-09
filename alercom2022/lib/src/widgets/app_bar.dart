import 'package:flutter/material.dart';

import 'package:alercom/src/utils/globals_util.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  AppBarWidget({
    required this.title,
    required this.icon,
    required this.onTapAction,
    this.bottom,
  }) : preferredSize = Size.fromHeight(Globals.appBarHeight), super();
  final String title;
  final String icon;
  final PreferredSizeWidget? bottom;
  final Function onTapAction;

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState(title, icon, bottom, onTapAction);
}


class _CustomAppBarState extends State<AppBarWidget>{
  final Color fontColor = Globals.fontColor;
  final Color backgroundColor = Globals.backgroundColor;
  final String title;
  final String icon;
  final PreferredSizeWidget? bottom;
  final Function onTapAction;

  _CustomAppBarState(this.title, this.icon, this.bottom, this.onTapAction);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Globals.fontColor),
        onPressed: (){ onTapAction();},
      ),
      bottom: bottom,
      iconTheme: IconThemeData(color: fontColor),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
          Image.asset(icon , fit: BoxFit.cover, height: 50,),
          Text(
              title,
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
    );
  }
}