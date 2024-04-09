import 'package:flutter/material.dart';

class ContadorPage extends StatefulWidget{
  @override
  createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage>{
  final _estiloTexto = new TextStyle(fontSize: 45);
  int _contador = 0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Alercom'),
        centerTitle: true,
        elevation: 55.5,
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Alertas registradas',
                style: _estiloTexto,
              ),
              Text(
                  '$_contador',
                  style: _estiloTexto),
            ],
          )
      ),
      floatingActionButton: _crearBotones()
    );
  }
  Widget _crearBotones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(width: 30.0),
        FloatingActionButton(
          child: Icon(Icons.exposure_zero),
          onPressed: _restaurar,
        ),
        Expanded(child: SizedBox()),
        FloatingActionButton(
          child: Icon(Icons.remove),
          onPressed: _sustraer,
        ),
        SizedBox(width: 5.0),
        FloatingActionButton(
          child: Icon(Icons.add_alert),
          onPressed: _adicionar,
        ),

      ],
    );
  }


  void _adicionar(){
    setState(() => _contador++ );
  }

  void _sustraer(){
    setState(() => _contador-- );
  }

  void _restaurar(){
    setState(() => _contador= 0  );
  }
}