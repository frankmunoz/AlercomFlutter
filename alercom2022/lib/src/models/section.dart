// To parse this JSON data, do
//
//     final place = sectionFromMap(jsonString);

import 'dart:convert';

class Section {
  Section({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Section.fromJson(String str) => Section.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Section.fromMap(Map<String, dynamic> json) => Section(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
  };

  Section copy() => Section(
    id: this.id,
    name: this.name,
  );
}
