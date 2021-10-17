import 'package:copapp/Model/Order/OrderHeader.dart';

class UpdateProductModel {
  int? orderHeaderId;
  OrderHeader? orderHeader;
  int? productId;
  int? qty;
  int? price;

  UpdateProductModel({
    this.orderHeaderId,
    this.orderHeader,
    this.productId,
    this.qty,
    this.price,
  });

  UpdateProductModel.fromJson(Map<String, dynamic> json) {
    orderHeaderId = json['orderHeaderId'] ?? 0;
    orderHeader = json['orderHeader'] != null
        ? new OrderHeader.fromJson(json['orderHeader'])
        : null;
    productId = json['productId'] ?? 0;
    qty = json['qty'] ?? 0;
    price = json['price'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderHeaderId'] = this.orderHeaderId;
    if (this.orderHeader != null) {
      data['orderHeader'] = this.orderHeader!.toJson();
    }
    data['productId'] = this.productId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}
