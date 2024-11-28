// To parse this JSON data, do
//
//     final products = productsFromJson(jsonString);

import 'dart:convert';

List<Products> productsFromJson(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromJson(x)));

String productsToJson(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Products {
    int id;
    int partsCat;
    String partImage;
    int vBrand;
    int vCategory;
    String price;
    String? partsName;
    String description;
    dynamic offerPrice;
    bool isOffer;
    String productRating;

    Products({
        required this.id,
        required this.partsCat,
        required this.partImage,
        required this.vBrand,
        required this.vCategory,
        required this.price,
        required this.partsName,
        required this.description,
        required this.offerPrice,
        required this.isOffer,
        required this.productRating,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json["id"],
        partsCat: json["parts_Cat"],
        partImage: json["part_image"],
        vBrand: json["v_brand"],
        vCategory: json["v_category"],
        price: json["price"],
        partsName: json["parts_name"],
        description: json["description"],
        offerPrice: json["offer_price"],
        isOffer: json["is_offer"],
        productRating: json["product_rating"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "parts_Cat": partsCat,
        "part_image": partImage,
        "v_brand": vBrand,
        "v_category": vCategory,
        "price": price,
        "parts_name": partsName,
        "description": description,
        "offer_price": offerPrice,
        "is_offer": isOffer,
        "product_rating": productRating,
    };
}
