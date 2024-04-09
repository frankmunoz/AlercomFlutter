import 'package:alercom/src/utils/globals_util.dart';
import 'package:flutter/material.dart';

class RaisedButtonUI extends StatelessWidget {

  RaisedButtonUI({required this.title, required this.icon, required this.bgColor, required this.onTapAction});
  final String title;
  final IconData icon;
  final Color bgColor;
  final Function onTapAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 400, // <-- Your width
        child: GestureDetector(
            child: Container(
                width:400,
                height: 70,
                decoration: BoxDecoration(
                    color: bgColor,
                    image: DecorationImage(
                        image:AssetImage("assets/icon.png"),
                        fit:BoxFit.cover
                    ),
                )
            ),
            onTap:onTapAction()
      )
    );

    return SizedBox(
        width: 400, // <-- Your width
        child:  ElevatedButton.icon(
          onPressed: (){ print('Button Clicked.'); },
          style: ElevatedButton.styleFrom(
            primary: bgColor,
            onPrimary: Globals.fontColor,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60.0))),
          ),
          label: Text(
            title,
            style: TextStyle(color: Globals.fontColor),
          ),
          icon: Icon(
            icon,
            color:Globals.fontColor,size: 70.0,
          ),
        )
    );
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          onTapAction();
        },   //accion del evento Onclick del widget Card
        splashColor:Colors.orange,
          child:Column(
            mainAxisSize:MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 70.0, color: bgColor),
              Text(title, style : new TextStyle(fontSize: 17.0), textAlign: TextAlign.center,)
            ],
        ),
      ),
    );
  }
}