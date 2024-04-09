import 'package:flutter/material.dart';

import 'package:alercom/src/providers/menu_provider.dart';
import 'package:alercom/src/utils/icono_string_util.dart';

import 'package:alercom/src/pages/components/alert_page.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {

//    print(menuProvider.opciones);
//    menuProvider.cargarData()
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: ( context,AsyncSnapshot<List<dynamic>> snapshot){
        return ListView(
         children: _listaItems(snapshot.data, context),
        );
      },
    );
  }

  List<Widget>_listaItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> opciones = [];
    data!.forEach((opcion) {
      final widgetTmp = ListTile(
        title: Text(opcion['texto']),
        leading: getIcon(opcion['icon']),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: (){
          Navigator.pushNamed(context, opcion['ruta']);
          /*
          final route = MaterialPageRoute(
            builder: (context) =>  AlertPage()
          );
          Navigator.push(context, route);
          */
        },
      );
      opciones..add(widgetTmp)
              ..add(Divider());
    });
    return opciones;
  }

}
