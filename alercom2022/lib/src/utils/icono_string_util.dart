import 'package:flutter/material.dart';
import 'package:alercom/src/utils/utils.dart';

const IconData pets = IconData(0xe4a1, fontFamily: 'MaterialIcons');
const IconData home_work_sharp = IconData(0xea17, fontFamily: 'MaterialIcons');
const IconData personal_injury = IconData(0xe49d, fontFamily: 'MaterialIcons');

final _icons = <String, IconData>{
  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'migration': Icons.vpn_lock,
  'vbg': Icons.wc,
  'child': Icons.volunteer_activism,
  'victims': Icons.wheelchair_pickup,
  'mind_health': Icons.accessibility,
  'pets': Icons.pets,
  'home_work_sharp': Icons.home_work_sharp,
  'affected_person': Icons.personal_injury,
  'agriculture':Icons.agriculture,
  'family_restroom_outlined':Icons.family_restroom_outlined,
  'nature_people':Icons.nature_people,
};

Icon getIcon(String iconName, [Color backgroundColor = Globals.backgroundColor]){
  return Icon( _icons[iconName], color: backgroundColor );
}