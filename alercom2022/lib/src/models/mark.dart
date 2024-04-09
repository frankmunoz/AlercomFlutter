// To parse this JSON data, do
//
//     final mark = markFromMap(jsonString);

import 'dart:convert';

class Mark {
  Mark({
    required this.id,
    required this.person,
    required this.category,
    required this.location,
    required this.name,
    required this.whenHappend,
    required this.whereHappend,
    required this.affectedsRange,
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
  String? affectedTo;
  String? observations;
  String? lat;
  String? lon;
  String? photo;

  factory Mark.fromJson(String str) => Mark.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mark.fromMap(Map<String, dynamic> json) => Mark(
    id: json["id"],
    person: json["person"],
    category: json["category"],
    location: json["location"],
    name: json["name"],
    whenHappend: json["when_happend"], //DateTime.parse(json["when_happend"]),
    whereHappend: json["where_happend"],
    affectedsRange: json["affecteds_range"],
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
   // "when_happend": whenHappend.toIso8601String(),
    "where_happend": whereHappend,
    "affecteds_range": affectedsRange,
    "affected_to": affectedTo,
    "observations": observations,
    "lat": lat,
    "lon": lon,
    "photo": photo,
  };


  Mark copy() => Mark(
    id: this.id,
    person: this.person,
    category: this.category,
    location: this.location,
    name: this.name,
    whenHappend: this.whenHappend,
    whereHappend: this.whereHappend,
    affectedsRange: this.affectedsRange,
    affectedTo: this.affectedTo,
    observations: this.observations,
    lat: this.lat,
    lon: this.lon,
    photo: this.photo,
  );
}
