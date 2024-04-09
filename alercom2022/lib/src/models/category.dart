// To parse this JSON data, do
//
//     final place = categoryFromMap(jsonString);

import 'dart:convert';

class Category {
  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
  });

  int id;
  String name;
  String description;
  int location;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    location: 0,
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "description": description,
  };

  Category copy() => Category(
    id: this.id,
    name: this.name,
    description: this.description,
    location: 0,
  );
}
