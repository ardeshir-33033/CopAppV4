import 'OrderDetail.dart';

class OrderHeader {
  String? title;
  String? description;
  String? code;
  double? sumPrice;
  double? decreasedPrice;
  double? increasedPrice;
  double? finalPrice;
  String? orderStatusId;
  List<OrderDetail>? orderDetails;
  String? deliveryProvince;
  String? deliveryCity;
  String? deliveryAddress;
  int? id;
  double? commissionPrice;
  String? paidTime;
  String? paidRefId;
  int? itemCount;
  double? totalScore;

  OrderHeader(
      {this.title,
      this.description,
      this.code,
      this.sumPrice,
      this.decreasedPrice,
      this.increasedPrice,
      this.finalPrice,
      this.orderStatusId,
      this.orderDetails,
      this.deliveryProvince,
      this.deliveryCity,
      this.deliveryAddress,
      this.id,
      this.commissionPrice,
      this.paidRefId,
      this.paidTime,
      this.itemCount,
      this.totalScore});

  OrderHeader.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    commissionPrice = json['commissionPrice'] ?? 0.0;
    paidRefId = json['paidRefId'] ?? "";
    paidTime = json['paidTime'] ?? "";
    code = json['code'] ?? "";
    sumPrice = json['sumPrice'] ?? 0.0;
    decreasedPrice = json['decreasedPrice'] ?? 0.0;
    increasedPrice = json['increasedPrice'] ?? 0.0;
    finalPrice = json['finalPrice'] ?? 0.0;
    orderStatusId = json['orderStatusId'] ?? "";
    if (json['orderDetails'] != null) {
      orderDetails = [];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetail.fromJson(v));
      });
    }
    deliveryProvince = json['deliveryProvince'] ?? "";
    deliveryCity = json['deliveryCity'] ?? "";
    deliveryAddress = json['deliveryAddress'] ?? "";
    id = json['id'] ?? 0;
    itemCount = json['itemCount'] ?? 0;
    totalScore = json['totalScore'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['commissionPrice'] = this.commissionPrice;
    data['code'] = this.code;
    data['sumPrice'] = this.sumPrice;
    data['decreasedPrice'] = this.decreasedPrice;
    data['increasedPrice'] = this.increasedPrice;
    data['finalPrice'] = this.finalPrice;
    // data['orderStatusId'] = this.orderStatusId;
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['deliveryProvince'] = this.deliveryProvince;
    data['deliveryCity'] = this.deliveryCity;
    data['deliveryAddress'] = this.deliveryAddress;
    data['id'] = this.id;
    data['totalScore'] = this.totalScore;
    data['itemCount'] = this.itemCount;
    return data;
  }

  List<OrderHeader>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<OrderHeader>((ct) {
        return OrderHeader.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
