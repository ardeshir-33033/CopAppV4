import 'package:copapp/AppModel/Balance/Product.dart';

import 'SaleRoles.dart';

class ConflictsQty {
  int? productId;
  Product? product;
  double? qty;
  double? unitPrice;
  double? decreasePrice;
  double? finalPrice;
  double? sumPrice;
  int? rowNumber;
  int? id;
  double? oldQty;
  double? oldUnitPrice;
  List<SaleRoles>? saleRoles;

  ConflictsQty(
      {this.productId,
        this.product,
        this.qty,
        this.unitPrice,
        this.decreasePrice,
        this.finalPrice,
        this.sumPrice,
        this.rowNumber,
        this.id,
        this.oldQty,
        this.oldUnitPrice,
        this.saleRoles});

  ConflictsQty.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    decreasePrice = json['decreasePrice'];
    finalPrice = json['finalPrice'];
    sumPrice = json['sumPrice'];
    rowNumber = json['rowNumber'];
    id = json['id'];
    oldQty = json['oldQty'];
    oldUnitPrice = json['oldUnitPrice'];
    if (json['saleRoles'] != null) {
      saleRoles = [];
      json['saleRoles'].forEach((v) {
        saleRoles!.add(new SaleRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['decreasePrice'] = this.decreasePrice;
    data['finalPrice'] = this.finalPrice;
    data['sumPrice'] = this.sumPrice;
    data['rowNumber'] = this.rowNumber;
    data['id'] = this.id;
    data['oldQty'] = this.oldQty;
    data['oldUnitPrice'] = this.oldUnitPrice;
    if (this.saleRoles != null) {
      data['saleRoles'] = this.saleRoles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<ConflictsQty>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ConflictsQty>((ct) {
        return ConflictsQty.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
