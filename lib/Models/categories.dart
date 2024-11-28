// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

List<Categories> categoriesFromJson(String str) => List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
    int id;
    String catName;

    Categories({
        required this.id,
        required this.catName,
    });

    factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        catName: json["Cat_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Cat_name": catName,
    };
}
