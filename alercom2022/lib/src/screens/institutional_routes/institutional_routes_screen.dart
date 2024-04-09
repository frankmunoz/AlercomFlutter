import 'package:flutter/material.dart';

import 'package:alercom/src/providers/menu_provider.dart';
import 'package:alercom/src/utils/utils.dart';
import 'package:alercom/src/widgets/app_bar.dart';

import 'package:alercom/src/pages/components/alert_page.dart';

class InstitutionalRoutesScreen extends StatelessWidget{
  Color backgroundColor = Globals.backgroundColor;
  Color backgroundColorLite = Globals.backgroundColorLite;
  Color fontColor = Globals.fontColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Rutas institucionales',
        icon: Globals.institutionalIcon,
        onTapAction: ()=>Navigator.of(context).pop(),
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
        trailing: Icon(Icons.keyboard_arrow_right, color: backgroundColor),
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
