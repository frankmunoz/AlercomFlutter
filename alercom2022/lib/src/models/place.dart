// To parse this JSON data, do
//
//     final place = categoryFromMap(jsonString);
/*
import 'dart:convert';

class Category {
  int id;
  String name;
  String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "description": description,
  };

  Category copy() => Category(
    id: this.id,
    name: this.name,
    description: this.description,
  );

}



// To parse this JSON data, do
//
//     final place = categoryFromMap(jsonString);
*/
import 'dart:convert';

class Place {
  Place({
    required this.id,
    required this.person,
    required this.name,
    required this.description,
    required this.when_happend,
    required this.where_happend,
    required this.affected_type,
    required this.affecteds_number,
    required this.observations,
    required this.lat,
    required this.lon,
    required this.photo,
    required this.active,
    required this.location,
    required this.category,
    required this.created_at,
    required this.updated_at,
  });

  int id;
  String person;
  String name;
  String description;
  String when_happend;
  String where_happend;
  String affected_type;
  int affecteds_number;
  String observations;
  String lat;
  String lon;
  String photo;
  int active;
  int location;
  int category;
  String created_at;
  String updated_at;

  factory Place.fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
    id: json["id"],
    person: json["person"],
    name: json["name"],
    description: json["description"],
    when_happend: json["when_happend"],
    where_happend: json["where_happend"],
    affected_type: json["affected_type"],
    affecteds_number: json["affecteds_number"],
    observations: json["observations"],
    lat: json["lat"],
    lon: json["lon"],
    photo: json["photo"],
    active: json["active"],
    location: json["location"],
    category: json["category"],
    created_at: json["created_at"],
    updated_at: json["updated_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "person": person,
    "name": name,
    "description": description,
    "when_happend": when_happend,
    "where_happend": where_happend,
    "affected_type": affected_type,
    "affecteds_number": affecteds_number,
    "observations": observations,
    "lat": lat,
    "lon": lon,
    "photo": photo,
    "active": active,
    "location": location,
    "category": category,
    "created_at": created_at,
    "updated_at": updated_at,
  };

  Place copy() => Place(
    id: this.id,
    person: this.person,
    name: this.name,
    description: this.description,
    when_happend: this.when_happend,
    where_happend: this.where_happend,
    affected_type: this.affected_type,
    affecteds_number: this.affecteds_number,
    observations: this.observations,
    lat: this.lat,
    lon: this.lon,
    photo: this.photo,
    active: this.active,
    location: this.location,
    category: this.category,
    created_at: this.created_at,
    updated_at: this.updated_at,
  );
}
