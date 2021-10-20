import 'package:copapp/AppModel/Balance/Product.dart';

class InquiryCart {
  List<InquiryDetails> details = [];
  int? inquiryId;

  InquiryCart({required this.details, this.inquiryId});

  InquiryCart.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      json['details'].forEach((v) {
        details.add(new InquiryDetails.fromJson(v));
      });
    }
    inquiryId = json['inquiryId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['details'] = this.details.map((v) => v.toJson()).toList();
    data['inquiryId'] = this.inquiryId;
    return data;
  }
}

class InquiryDetails {
  Product? product;
  double? lastSalePrice;
  int? inquiryDetailId;

  InquiryDetails({this.product, this.inquiryDetailId});

  InquiryDetails.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = new Product.fromJson(json['product']);
      product!.detailQTY = json['qty'].toInt();
    }
    // qty = json['qty'].toInt();
    lastSalePrice = json['lastSalePrice'];
    inquiryDetailId = json['inquiryDetailId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['lastSalePrice'] = this.lastSalePrice;
    data['inquiryDetailId'] = this.inquiryDetailId;
    return data;
  }
}
