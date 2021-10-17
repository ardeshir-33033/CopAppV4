import 'package:copapp/AppModel/Images/ProductImages.dart';

class InquiryModel {
  String? productName;
  String? country;
  String? brandName;
  int? productInfoPrice;
  int? score;
  int? multipleQTY;
  int? productVirtualQTY;
  bool? warranty;
  List<ProductImage>? images;
  double? lastMarketPrice;

  InquiryModel({
    this.productName,
    this.country,
    this.brandName,
    this.productInfoPrice,
    this.score,
    this.multipleQTY,
    this.productVirtualQTY,
    this.warranty,
    this.images,
    this.lastMarketPrice,
  });

  InquiryModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    country = json['country'];
    brandName = json['brandName'];
    productInfoPrice = json['productName'];
    score = json['score'];
    multipleQTY = json['multipleQTY'];
    productVirtualQTY = json['productVirtualQTY'];
    warranty = json['warranty'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images!.add(ProductImage.fromJson(v));
      });
    }
    lastMarketPrice = json['lastMarketPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['country'] = this.country;
    data['brandName'] = this.brandName;
    data['productInfoPrice'] = this.productInfoPrice;
    data['score'] = this.score;
    data['multipleQTY'] = this.multipleQTY;
    data['productVirtualQTY'] = this.productVirtualQTY;
    data['warranty'] = this.warranty;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['lastMarketPrice'] = this.lastMarketPrice;

    return data;
  }
}
