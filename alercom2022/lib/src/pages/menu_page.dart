import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget{
  final opciones = ['Uno','Dos','Tres','Cuatro','Cinco'];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Alercom',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
        ),
        body: ListView(
            //children: _crearItems()
            children: _crearItemsCorta()
        ),
      ),
    );
  }

  List<Widget> _crearItems(){
    List<Widget> lista = [];
    for(String opcion in opciones){
      final tempWidget = ListTile(
        title: Text( opcion ),
      );
      lista..add(tempWidget)
           ..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta(){
    var widgets = opciones.map( ( item){
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(item + '!'),
            subtitle: Text('ANy thing'),
            leading: Icon( Icons.add_alert ),
            trailing: Icon( Icons.keyboard_arrow_right),
            onTap: (){},
          ),
          Divider(),
        ],
      );
    }).toList();

    return widgets;
  }
}