// To parse this JSON data, do
//
//     final place = contentFromMap(jsonString);

import 'dart:convert';

class Content {
  Content({
    required this.id,
    required this.section,
    required this.name,
    required this.description,
  });

  int id;
  int section;
  String name;
  String description;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
    id: json["id"],
    section: json["section"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "section": section,
    "name": name,
    "description": description,
  };

  Content copy() => Content(
    id: this.id,
    section: this.section,
    name: this.name,
    description: this.description,
  );
}
