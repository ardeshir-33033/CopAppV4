import 'Product.dart';

class InquiryDetail {
  int? productId;
  Product? product;
  double? qty;
  double? unitPrice;
  double? decreasePrice;
  double? finalPrice;
  double? sumPrice;
  int? id;

  InquiryDetail(
      {this.productId,
        this.product,
        this.qty,
        this.unitPrice,
        this.decreasePrice,
        this.finalPrice,
        this.sumPrice,
        this.id});

  InquiryDetail.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    qty = json['qty'];
    unitPrice = json['unitPrice'];
    decreasePrice = json['decreasePrice'];
    finalPrice = json['finalPrice'];
    sumPrice = json['sumPrice'];
    id = json['id'];
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
    data['id'] = this.id;
    return data;
  }

  List<InquiryDetail>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<InquiryDetail>((ct) {
        return InquiryDetail.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
