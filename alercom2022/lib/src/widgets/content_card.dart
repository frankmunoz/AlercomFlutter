import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:alercom/src/models/models.dart';
import 'package:alercom/src/utils/utils.dart';



class ContentCard extends StatelessWidget {

  final Content content;

  const ContentCard({
    Key? key,
    required this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Globals.backgroundColor;

    return Column(
      children: <Widget>[
        Divider(height: 5.0),
        ListTile(
          title: Text(
            '${content.name}',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.deepOrangeAccent,
            ),
          ),
          subtitle: Html(
            data: '${content.description}',
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
            color: Colors.black12,
            offset: Offset(0,7),
            blurRadius: 10
        )
      ]
  );
}
