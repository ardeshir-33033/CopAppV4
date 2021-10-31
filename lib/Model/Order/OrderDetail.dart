import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/AppModel/Cart/CartDetail.dart';


class OrderDetail {
  int? orderHeaderId;
  double? unitPrice;
  double? sumPrice;
  double? decreasedPrice;
  double? increasedPrice;
  double? finalPrice;
  Product? product;
  int? id;


  OrderDetail({
    this.orderHeaderId,
    this.unitPrice,
    this.sumPrice,
    this.decreasedPrice,
    this.increasedPrice,
    this.finalPrice,
    this.product,
    this.id,

  });

  OrderDetail.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'] ?? 0;
    unitPrice = json['unitPrice'] ?? 0;
    sumPrice = json['sumPrice'] ?? 0;
    decreasedPrice = json['decreasedPrice'] ?? 0;
    increasedPrice = json['increasedPrice'] ?? 0;
    finalPrice = json['finalPrice'] ?? 0;
    id = json['id'] ?? 0;
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderHeaderId'] = this.orderHeaderId;
    data['unitPrice'] = this.unitPrice;
    data['sumPrice'] = this.sumPrice;
    data['decreasedPrice'] = this.decreasedPrice;
    data['increasedPrice'] = this.increasedPrice;
    data['finalPrice'] = this.finalPrice;
    data['id'] = this.id;
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
          detailUnitPrice: e.unitPrice,
          detailFinalPrice: e.finalPrice,
          detailDecreasePrice: e.decreasedPrice,
          detailId: e.id,
          product: e.product,
          // detailQTY: e.quantity!.toInt(),
          detailSumPrice: e.sumPrice
        );
      }).toList();
    }
  }
}
