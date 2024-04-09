import 'dart:async';
import 'dart:convert';

import 'package:alercom/src/providers/providers.dart';
import 'package:alercom/src/utils/globals_util.dart';
import 'package:alercom/src/utils/icono_string_util.dart';
import 'package:flutter/material.dart';


class AffectedType extends StatefulWidget {
  AffectedType(this.markForm);
  final MarkFormProvider markForm;

  @override
  _AffectedTypeState createState() => _AffectedTypeState(markForm);
}

class _AffectedTypeState extends State<AffectedType> {
  final List isSwitched = [];
  final List switchedOn = [];
  final MarkFormProvider markForm;
  _AffectedTypeState(this.markForm);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Data>>(
      future: _fetchdata(),
      builder: (context, snapshot) {
        List<Data>? data = snapshot.data;
        return _dataListView(data);
      },
    );
  }

  Future<List<Data>> _fetchdata() async {

    List<Map<String, dynamic>> _affectedType = [
      {'title': 'Personas', 'subtitle':'', 'icon':'affected_person','selected':'false'},
      {'title': 'Familias', 'subtitle':'', 'icon':'family_restroom_outlined','selected':'false'},
      {'title': 'Animales', 'subtitle':'','icon':'pets','selected':'false'},
      {'title': 'Infraestructuras', 'subtitle':'', 'icon':'home_work_sharp','selected':'false'},
      {'title': 'Medios de vida', 'subtitle':'', 'icon':'nature_people','selected':'false'},
    ];
    List jsonResponse = json.decode(json.encode(_affectedType));

    return jsonResponse.map((job) => new Data.fromJson(job)).toList();
  }

  ListView _dataListView(data) {
    var totalItems = 0;
    try{
      totalItems = data.length;
      for(int i = 0; i < data.length; i++) {
        isSwitched.add(false);
      }
    }catch(e){
      print(e.toString());
    }
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: totalItems,
        itemBuilder: (context, index) {
          //return Text("asd");
          return SwitchListTile(
            activeColor: Globals.backgroundColor,
            activeTrackColor: Globals.fontColor,

//            inactiveThumbColor: Globals.backgroundColorLite,
//            inactiveTrackColor: Globals.backgroundColorLite,

            controlAffinity: ListTileControlAffinity.leading,
            secondary: getIcon(data[index].icon, isSwitched[index]?Globals.backgroundColor:Colors.black54),
            title: Text(data[index].title,
                style: TextStyle(
                  color: isSwitched[index]?Globals.backgroundColor:Colors.black54,
                  fontSize: 15,
                )),
            subtitle: Text(data[index].subtitle,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                )),
            value: isSwitched[index],
            onChanged: (bool value) {
              setState(() {
                isSwitched[index] = !isSwitched[index];
                if(value)
                  switchedOn.add(data[index].title);
                else
                  switchedOn.remove(data[index].title);
                markForm.affectedTo = switchedOn.toString();
                print(markForm.affectedTo);
              });
            },
          );
        });
  }
}

class Data {
  final String title;
  final String subtitle;
  final String icon;

  Data({required this.title, required this.subtitle, required this.icon});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      title: json['title'],
      subtitle: json['subtitle'],
      icon: json['icon'],
    );
  }
}