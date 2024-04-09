import 'package:alercom/src/utils/globals_util.dart';
import 'package:flutter/material.dart';

class ButtonUI extends StatelessWidget {

  ButtonUI({
    required this.title,
    required this.image,
    required this.withIcon,
    required this.icon,
    required this.bgColor,
    required this.fontColor,
    required this.onTapAction
  });
  final String title;
  final String image;
  final bool withIcon;
  final IconData icon;
  final Color bgColor;
  final Color fontColor;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: bgColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(60.0),
        ),
      child: InkWell(
        onTap: () {onTapAction(); },   //accion del evento Onclick del widget Card
        splashColor:Colors.orange,
        child: Center(
          child:Column(
            mainAxisSize:MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: withIcon?
                Icon(icon, size: 50.0, color: fontColor) :
                CircleAvatar(
                  backgroundImage: AssetImage(image),
                  backgroundColor: Colors.white,
                ),
                title: Text(title, style : new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0, color: fontColor, ), textAlign: TextAlign.left,)
                //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}