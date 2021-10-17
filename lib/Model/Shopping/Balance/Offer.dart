import 'dart:developer';

import '../../Brand.dart';
import '../../Country.dart';
import '../../Part.dart';
import '../../ProductImage.dart';
import '../../ProductInfo.dart';
import '../../Unit.dart';


class Offer {
  String? name;
  String? code;
  Unit? unit;
  Brand? brand;
  Part? part;
  Country? country;
  List<ProductImage>? images;
  List<ProductInfo>? productInfos;
  int? qtyCart;
  int? sumSale;
  int? id;

  Offer({
    this.name,
    this.code,
    this.unit,
    this.brand,
    this.part,
    this.country,
    this.images,
    this.productInfos,
    this.qtyCart,
    this.sumSale,
    this.id,
  });

  Offer.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    code = json['code'] ?? "";
    unit = json['unit'] != null ? new Unit.fromJson(json['unit']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    part = json['part'] != null ? new Part.fromJson(json['part']) : null;
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(new ProductImage.fromJson(v));
      });
    }
    if (json['productInfos'] != null) {
      productInfos = [];
      json['productInfos'].forEach((v) {
        productInfos!.add(new ProductInfo.fromJson(v));
      });
    }
    qtyCart = json['qtyCart'];
    sumSale = json['sumSale'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.unit != null) {
      data['unit'] = this.unit!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.part != null) {
      data['part'] = this.part!.toJson();
    }
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.productInfos != null) {
      data['productInfos'] = this.productInfos!.map((v) => v.toJson()).toList();
    }
    data['qtyCart'] = this.qtyCart;
    data['sumSale'] = this.sumSale;
    data['id'] = this.id;
    return data;
  }

  List<Offer>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Offer>((ct) {
        return Offer.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
