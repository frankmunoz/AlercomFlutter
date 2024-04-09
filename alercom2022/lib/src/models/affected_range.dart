
import 'package:flutter/material.dart';

import 'package:alercom/src/providers/providers.dart';
import 'package:alercom/src/utils/utils.dart';

class AffectedRange extends StatefulWidget {
  AffectedRange(this.markForm);
  final MarkFormProvider markForm;

  @override
  _AffectedRangeState createState() => _AffectedRangeState(markForm);
}

class _AffectedRangeState extends State<AffectedRange> {
  final MarkFormProvider markForm;

  _AffectedRangeState(this.markForm);
  @override
  Widget build(BuildContext context) {
    return buildDropdownButtonFormField();
  }

  DropdownButtonFormField<String> buildDropdownButtonFormField() {
    return DropdownButtonFormField<String>(
      decoration:  InputDecoration(
        focusColor: Globals.backgroundColor,
        hoverColor: Globals.backgroundColor,
        fillColor: Globals.backgroundColor,
        contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
        labelText: "Seleccione rango de afectaciones",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        icon: Icon(Icons.format_list_numbered, color: Globals.backgroundColor,),
        suffixIcon: Icon(Icons.format_line_spacing, color: Globals.backgroundColor,),
      ),

      items: ["entre 1 y 5","entre 5 y 10", "entre 11 y 20", "entre 21 y 50","entre 51 y 100","Mas de 100"].map((label) => DropdownMenuItem(
        child: Text(label),
        value: label,
      )).toList(),
      onChanged: (option) {
        markForm.affectedsRange = option.toString();
        print(markForm.affectedsRange);
      },
    );
  }
}