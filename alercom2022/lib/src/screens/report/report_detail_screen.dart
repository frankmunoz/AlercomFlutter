import 'package:alercom/src/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


import 'package:alercom/src/providers/login_form_provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';
import '../screens.dart';

import 'package:alercom/src/utils/utils.dart';

class ReportDetailScreen extends StatelessWidget {
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false );
    final reportService = Provider.of<ReportService>(context);
    final report = reportService.selectedReport;

    if(reportService.isLoading) return LoadingScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Ver reportes',
        icon: Globals.reportIcon,
        onTapAction: ()=>Navigator.of(context).pop(),

      ),
      body: buildBody(authService, report),

    );
  }


  Center buildBody(AuthService authService, Report report) {
    return Center(
        child: FutureBuilder(
            future: authService.retrievingData('location'),
            builder: (BuildContext context, AsyncSnapshot<String> shapshot){
              return buildPadding(shapshot, authService, report);
            }
        )
    );
  }

  Padding buildPadding(AsyncSnapshot<String> shapshot, AuthService authService, Report report) {
    String location = authService.getProfileValuesByKey('location');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListTile(
        title: Text(
          report.categoryName,
          style: TextStyle(color: Globals.backgroundColor, fontWeight: FontWeight.w800, fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(height: 20,),
            Text(
              location + "¿Qué ocurrió?: " + report.name,
              style: TextStyle(color: Globals.backgroundColor, fontWeight: FontWeight.w800, fontSize: 20),
            ),
            Text(
              "Lugar: " + report.locationName,
              style: TextStyle( fontSize: 15, color: Colors.black54, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "Fecha: " + report.whenHappend,
              style: TextStyle( fontSize: 15, color: Colors.black54 ),
            ),
            SizedBox(height: 20,),

            Text(
              "¿Dónde ocurrió? " + report.whereHappend,
              style: TextStyle( fontSize: 15, color: Colors.black ),
            ),
            SizedBox(height: 5,),
            Text(
              "Afectacó a: " + report.affectedTo.toString(),
              style: TextStyle( fontSize: 15, color: Colors.black ),
            ),
            SizedBox(height: 5,),
            Text(
              "Número de afectaciones: " + report.affectedsRange,
              style: TextStyle( fontSize: 15, color: Colors.black ),
            ),
            SizedBox(height: 5,),
            Text(
              "Obervaciones: " + report.observations.toString(),
              style: TextStyle( fontSize: 15, color: Colors.black ),
            ),
          ],

        ),//Text(report.whereHappend),
      ),
    );
  }
}
