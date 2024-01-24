// To parse this JSON data, do
//
//     final productDataModel = productDataModelFromJson(jsonString);

import 'dart:convert';

//List<ProductDataModel> productDataModelFromJson(String str) => List<ProductDataModel>.from(json.decode(str).map((x) => ProductDataModel.fromJson(x)));

//String productDataModelToJson(List<ProductDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductDataModel {
    int? prodId;
    String? prodname;
    int? purprice;
    int? selprice;

    ProductDataModel({
        this.prodId,
        this.prodname,
        this.purprice,
        this.selprice,
    });

    factory ProductDataModel.fromMap(Map<String, dynamic> json) => ProductDataModel(
        prodId: json["prodId"],
        prodname: json["prodname"],
        purprice: json["purprice"],
        selprice: json["selprice"],
    );

    Map<String, dynamic> toMap() => {
        "prodId": prodId,
        "prodname": prodname,
        "purprice": purprice,
        "selprice": selprice,
    };
}
