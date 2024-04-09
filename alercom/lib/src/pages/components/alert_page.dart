import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Alertas'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=> _mostrarAlerta(context),
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            shape: StadiumBorder()
          ),
          child: Text('Mostrar Alerta'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon( Icons.keyboard_arrow_left_sharp),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
    );
  }

  void _mostrarAlerta(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return AlertDialog(
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(20.0)),
            title: Text('Titulo'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Este ers el contenido de la caja de alerta'),
                FlutterLogo( size: 100.0)
              ],
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: ()=>Navigator.of(context).pop(),
                  child: Text('Cancelar')
              ),
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