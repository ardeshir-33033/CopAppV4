import 'package:copapp/Model/Order/OrderDetail.dart';

class CreateOrder {
  List<OrderDetail>? orderDetails;
  int? profileId;
  String? authority;
  String? referenceId;
  String? deliveryProvince;
  String? deliveryCity;
  String? deliveryAddress;

  CreateOrder({
    this.orderDetails,
    this.profileId,
    this.authority,
    this.referenceId,
    this.deliveryProvince,
    this.deliveryCity,
    this.deliveryAddress,
  });

  CreateOrder.fromJson(Map<String, dynamic> json) {
    if (json['orderDetails'] != null) {
      orderDetails = [];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(OrderDetail.fromJson(v));
      });
    }
    profileId = json['profileId'] ?? 0;
    authority = json['authority'] ?? "";
    referenceId = json['referenceId'] ?? 0;
    deliveryProvince = json['deliveryProvince'] ?? "";
    deliveryCity = json['deliveryCity'] ?? "";
    deliveryAddress = json['deliveryAddress'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['profileId'] = this.profileId;
    data['authority'] = this.authority;
    data['referenceId'] = this.referenceId;
    data['deliveryProvince'] = this.deliveryProvince;
    data['deliveryCity'] = this.deliveryCity;
    data['deliveryAddress'] = this.deliveryAddress;
    return data;
  }
}
