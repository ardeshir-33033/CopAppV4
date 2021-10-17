import 'package:copapp/AppModel/Balance/Product.dart';

class CartDetail {
  int? detailId;
  double? detailDecreasePrice;
  double? detailFinalPrice;
  double? detailIncreasePrice;
  int? detailQTY;
  double? detailSumPrice;
  double? detailUnitPrice;
  Product? product;

  CartDetail(
      {this.detailId,
      this.detailDecreasePrice,
      this.detailFinalPrice,
      this.detailIncreasePrice,
      this.detailQTY,
      this.detailSumPrice,
      this.detailUnitPrice,
      this.product});

  CartDetail.fromJson(Map<String, dynamic> json) {
    detailId = json['detailId'];
    detailDecreasePrice = json['detailDecreasePrice'];
    detailFinalPrice = json['detailFinalPrice'];
    detailIncreasePrice = json['detailIncreasePrice'];
    detailQTY = json['detailQTY'];
    detailSumPrice = json['detailSumPrice'];
    detailUnitPrice = json['detailUnitPrice'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailId'] = this.detailId;
    data['detailDecreasePrice'] = this.detailDecreasePrice;
    data['detailFinalPrice'] = this.detailFinalPrice;
    data['detailIncreasePrice'] = this.detailIncreasePrice;
    data['detailQTY'] = this.detailQTY;
    data['detailSumPrice'] = this.detailSumPrice;
    data['detailUnitPrice'] = this.detailUnitPrice;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }

  List<CartDetail>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<CartDetail>((ct) {
        return CartDetail.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
