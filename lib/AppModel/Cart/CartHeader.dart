import 'package:copapp/AppModel/Cart/CartDetail.dart';

class CartHeader {
  int? orderId;
  double? orderDecreasePrice;
  double? orderFinalPrice;
  double? orderIncreasePrice;
  double? orderSumPrice;
  List<CartDetail>? details;

  CartHeader(
      {this.orderId,
      this.orderDecreasePrice,
      this.orderFinalPrice,
      this.orderIncreasePrice,
      this.orderSumPrice,
      this.details});

  CartHeader.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderDecreasePrice = json['orderDecreasePrice'];
    orderFinalPrice = json['orderFinalPrice'];
    orderIncreasePrice = json['orderIncreasePrice'];
    orderSumPrice = json['orderSumPrice'];
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details!.add(new CartDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['orderDecreasePrice'] = this.orderDecreasePrice;
    data['orderFinalPrice'] = this.orderFinalPrice;
    data['orderIncreasePrice'] = this.orderIncreasePrice;
    data['orderSumPrice'] = this.orderSumPrice;
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
    List<CartHeader>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<CartHeader>((ct) {
        return CartHeader.fromJson(ct);
      }).toList();
    }

    return null;
  }
}



