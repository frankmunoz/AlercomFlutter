// To parse this JSON data, do
//
//     final mark = markFromMap(jsonString);

import 'dart:convert';

class Report {
  Report({
    required this.id,
    required this.person,
    required this.category,
    required this.location,
    required this.name,
    required this.whenHappend,
    required this.whereHappend,
    required this.affectedsRange,
    required this.locationName,
    required this.categoryName,
    this.affectedTo,
    this.observations,
    this.lat,
    this.lon,
    this.photo,
  });

  int id;
  int person;
  int category;
  int location;
  String name;
  String whenHappend;
  String whereHappend;
  String affectedsRange;
  String locationName;
  String categoryName;
  String? affectedTo;
  String? observations;
  String? lat;
  String? lon;
  String? photo;

  factory Report.fromJson(String str) => Report.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Report.fromMap(Map<String, dynamic> json) => Report(
    id: json["id"],
    person: json["person"],
    category: json["category"],
    location: json["location"],
    name: json["name"],
    whenHappend: json["when_happend"],
    whereHappend: json["where_happend"],
    affectedsRange: json["affecteds_range"],
    locationName: json["location_name"],
    categoryName: json["category_name"],
    affectedTo: json["affected_to"],
    observations: json["observations"],
    lat: json["lat"],
    lon: json["lon"],
    photo: json["photo"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "person": person,
    "category": category,
    "location": location,
    "name": name,
    "when_happend": whenHappend,
    "where_happend": whereHappend,
    "affecteds_range": affectedsRange,
    "location_name": locationName,
    "category_name": categoryName,
    "affected_to": affectedTo,
    "observations": observations,
    "lat": lat,
    "lon": lon,
    "photo": photo,
  };


  Report copy() => Report(
    id: this.id,
    person: this.person,
    category: this.category,
    location: this.location,
    name: this.name,
    whenHappend: this.whenHappend,
    whereHappend: this.whereHappend,
    affectedsRange: this.affectedsRange,
    locationName: this.locationName,
    categoryName: this.categoryName,
    affectedTo: this.affectedTo,
    observations: this.observations,
    lat: this.lat,
    lon: this.lon,
    photo: this.photo,
  );
}
