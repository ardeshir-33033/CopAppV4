import 'package:copapp/Model/CartDetail.dart';

import '../Product.dart';

class OrderDetail {
  int? orderHeaderId;
  int? productId;
  double? quantity;
  double? unitPrice;
  double? sumPrice;
  double? decreasedPrice;
  double? increasedPrice;
  double? finalPrice;
  Product? product;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  OrderDetail({
    this.orderHeaderId,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.sumPrice,
    this.decreasedPrice,
    this.increasedPrice,
    this.finalPrice,
    this.product,
    this.id,
    this.createDm,
    this.createDs,
    this.lastUpdateDm,
    this.lastUpdateDs,
  });

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'] ?? 0;
    productId = json['productId'] ?? 0;
    quantity = json['qty'] ?? 0;
    unitPrice = json['unitPrice'] ?? 0;
    sumPrice = json['sumPrice'] ?? 0;
    decreasedPrice = json['decreasedPrice'] ?? 0;
    increasedPrice = json['increasedPrice'] ?? 0;
    finalPrice = json['finalPrice'] ?? 0;
    id = json['id'] ?? 0;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderHeaderId'] = this.orderHeaderId;
    data['productId'] = this.productId;
    data['qty'] = this.quantity;
    data['unitPrice'] = this.unitPrice;
    data['sumPrice'] = this.sumPrice;
    data['decreasedPrice'] = this.decreasedPrice;
    data['increasedPrice'] = this.increasedPrice;
    data['finalPrice'] = this.finalPrice;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }

  List<OrderDetail>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OrderDetail>((ct) {
        return OrderDetail.fromJson(ct);
      }).toList();
    }

    return null;
  }

  List<CartDetail>? toCartDetail(List<OrderDetail>? list) {
    if (list != null) {
      return list.map<CartDetail>((e) {
        return CartDetail(
          unitPrice: e.unitPrice,
          finalPrice: e.finalPrice,
          decreasePrice: e.decreasedPrice,
          id: e.id,
          product: e.product,
          productId: e.productId,
          qty: e.quantity,
          sumPrice: e.sumPrice
        );
      }).toList();
    }
  }
}
