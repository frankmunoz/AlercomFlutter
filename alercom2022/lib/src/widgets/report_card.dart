import 'package:flutter/material.dart';

import 'package:alercom/src/models/models.dart';
import 'package:alercom/src/utils/utils.dart';

class ReportCard extends StatelessWidget {

  final Report report;

  const ReportCard({
    Key? key,
    required this.report
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Globals.backgroundColor;
  return Card(
        child: ListTile(
        title: Text(report.name),
    subtitle: Text(report.whereHappend),
    /*leading: CircleAvatar(
    backgroundImage: NetworkImage(
    "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
    trailing: Icon(icons[index])));
    }*/
    )
  );
  }

}
