import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';


import 'package:alercom/src/providers/login_form_provider.dart';
import 'package:alercom/src/services/services.dart';
import 'package:alercom/src/widgets/widgets.dart';
import 'package:alercom/src/ui/input_decoration_ui.dart';
import '../screens.dart';

import 'package:alercom/src/utils/utils.dart';



class ReportScreen extends StatelessWidget {
  Color backgroundColor = Globals.backgroundColor;
  Color fontColor = Globals.fontColor;

  @override
  Widget build(BuildContext context) {
    final reportService = Provider.of<ReportService>(context);

    if(reportService.isLoading) return LoadingScreen();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget(
        title: 'Ver reportes',
        icon: Globals.reportIcon,
        onTapAction: ()=>Navigator.of(context).pop(),

      ),
      body: ListView.builder(
          itemCount: reportService.reports.length,
          itemBuilder: ( BuildContext context, int index ) => GestureDetector(
            onTap: () {
              reportService.selectedReport = reportService.reports[index].copy();
              Navigator.pushNamed(context, 'report_detail');
            },
            child: ReportCard(
              report: reportService.reports[index],
            ),
          )
      ),
    );
  }
}
