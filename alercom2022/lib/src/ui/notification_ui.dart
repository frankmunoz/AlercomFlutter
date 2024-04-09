import 'package:flutter/material.dart';


class NotificationUI{
  static notify({
      required BuildContext context,
      required String title,
      required String message,
    }){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message),
              //FlutterLogo( size: 100.0)
            ],
          ),
          actions: <Widget>[
            /*
            TextButton(
                onPressed: ()=>Navigator.of(context).pop(),
                child: Text('Cancelar')
            ),*/
            TextButton(
                onPressed: ()=>Navigator.of(context).pop(),
                child: Text('Ok')
            ),
          ],
        );
      }
    );
  }

}