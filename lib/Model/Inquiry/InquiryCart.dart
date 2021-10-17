
import 'package:copapp/AppModel/Balance/Product.dart';

class InquiryCart {
  List<InquiryDetails> inquiryDetails = [];
  double? decreasePrice;
  double? sumPrice;
  double? finalPrice;
  int? id;

  InquiryCart(
      {required this.inquiryDetails,
      this.decreasePrice,
      this.sumPrice,
      this.finalPrice,
      this.id});

  InquiryCart.fromJson(Map<String, dynamic> json) {
    if (json['inquiryDetails'] != null) {
      json['inquiryDetails'].forEach((v) {
        inquiryDetails.add(new InquiryDetails.fromJson(v));
      });
    } 
    decreasePrice = json['decreasePrice'];
    sumPrice = json['sumPrice'];
    finalPrice = json['finalPrice'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['inquiryDetails'] =
        this.inquiryDetails.map((v) => v.toJson()).toList();

    data['decreasePrice'] = this.decreasePrice;
    data['sumPrice'] = this.sumPrice;
    data['finalPrice'] = this.finalPrice;
    data['id'] = this.id;
    return data;
  }
}

class InquiryDetails {
  Product? product;
  int? productId;
  int? qty;
  double? unitPrice;
  double? decreasePrice;
  double? finalPrice;
  double? sumPrice;
  int? id;

  InquiryDetails(
      {this.product,
      this.productId,
      this.qty,
      this.unitPrice,
      this.decreasePrice,
      this.finalPrice,
      this.sumPrice,
      this.id});

  InquiryDetails.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    productId = json['productId'];
    qty = json['qty'].toInt();
    unitPrice = json['unitPrice'];
    decreasePrice = json['decreasePrice'];
    finalPrice = json['finalPrice'];
    sumPrice = json['sumPrice'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['productId'] = this.productId;
    data['qty'] = this.qty;
    data['unitPrice'] = this.unitPrice;
    data['decreasePrice'] = this.decreasePrice;
    data['finalPrice'] = this.finalPrice;
    data['sumPrice'] = this.sumPrice;
    data['id'] = this.id;
    return data;
  }
}
