import 'ConflictsPrice.dart';
import 'ConflictsQty.dart';
import 'Order/Buyer.dart';
import 'Order/OrderStatus.dart';
import 'Product.dart';

class FilterResponseModel {
  int? id;
  String? code;
  String? title;
  String? description;
  Buyer? buyer;
  List<OrderDetails>? orderDetails;
  String? orderStatusId;
  OrderStatus? orderStatus;
  List<Shippings>? shippings;
  List<ConflictsQty>? conflictsQty;
  List<ConflictsPrice>? conflictsPrice;
  int? profileId;
  String? paymentDocAuthority;
  String? referenceId;
  String? deliveryProvince;
  String? deliveryCity;
  String? deliveryAddress;
  String? createDm;
  String? createDs;
  double? finalPrice;
  double? sumPrice;
  String? paidTime;

  FilterResponseModel(
      {this.id,
      this.code,
      this.title,
      this.description,
      this.buyer,
      this.orderDetails,
      this.orderStatusId,
      this.orderStatus,
      this.shippings,
      this.conflictsQty,
      this.conflictsPrice,
      this.profileId,
      this.paymentDocAuthority,
      this.referenceId,
      this.deliveryProvince,
      this.deliveryCity,
      this.deliveryAddress,
      this.createDm,
      this.createDs,
      this.finalPrice,
      this.sumPrice,
      this.paidTime});

  FilterResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    title = json['title'];
    description = json['description'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    if (json['orderDetails'] != null) {
      orderDetails = [];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
    orderStatusId = json['orderStatusId'];
    orderStatus = json['orderStatus'] != null
        ? new OrderStatus.fromJson(json['orderStatus'])
        : null;
    if (json['shippings'] != null) {
      shippings = [];
      json['shippings'].forEach((v) {
        shippings!.add(new Shippings.fromJson(v));
      });
    }
    if (json['conflictsQty'] != null) {
      conflictsQty = [];
      json['conflictsQty'].forEach((v) {
        conflictsQty!.add(new ConflictsQty.fromJson(v));
      });
    }
    if (json['conflictsPrice'] != null) {
      conflictsPrice = [];
      json['conflictsPrice'].forEach((v) {
        conflictsPrice!.add(new ConflictsPrice.fromJson(v));
      });
    }
    profileId = json['profileId'];
    paymentDocAuthority = json['paymentDocAuthority'];
    referenceId = json['referenceId'];
    deliveryProvince = json['deliveryProvince'];
    deliveryCity = json['deliveryCity'];
    deliveryAddress = json['deliveryAddress'];
    createDm = json['createDm'];
    createDs = json['createDs'];
    finalPrice = json['finalPrice'];
    sumPrice = json['sumPrice'];
    paidTime = json['paidTime'];
  }

  List<FilterResponseModel>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<FilterResponseModel>((ct) {
        return FilterResponseModel.fromJson(ct);
      }).toList();
    }

    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    data['orderStatusId'] = this.orderStatusId;
    if (this.orderStatus != null) {
      data['orderStatus'] = this.orderStatus!.toJson();
    }
    if (this.shippings != null) {
      data['shippings'] = this.shippings!.map((v) => v.toJson()).toList();
    }
    if (this.conflictsQty != null) {
      data['conflictsQty'] = this.conflictsQty!.map((v) => v.toJson()).toList();
    }
    if (this.conflictsPrice != null) {
      data['conflictsPrice'] =
          this.conflictsPrice!.map((v) => v.toJson()).toList();
    }
    data['profileId'] = this.profileId;
    data['paymentDocAuthority'] = this.paymentDocAuthority;
    data['referenceId'] = this.referenceId;
    data['deliveryProvince'] = this.deliveryProvince;
    data['deliveryCity'] = this.deliveryCity;
    data['deliveryAddress'] = this.deliveryAddress;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['finalPrice'] = this.finalPrice;
    data['sumPrice'] = this.sumPrice;
    data['paidTime'] = this.sumPrice;
    return data;
  }
}

class OrderDetails {
  int? productId;
  Product? product;
  double? qty;
  double? price;
  double? oldQty;
  double? oldUnitPrice;
  double? unitPrice;
  double? finalPrice;
  double? sumPrice;

  OrderDetails(
      {this.productId,
      this.product,
      this.qty,
      this.price,
      this.oldQty,
      this.oldUnitPrice,
      this.unitPrice,
      this.finalPrice,
      this.sumPrice});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    qty = json['qty'];
    price = json['price'];
    oldQty = json['oldQty'];
    oldUnitPrice = json['oldUnitPrice'];
    unitPrice = json['unitPrice'];
    finalPrice = json['finalPrice'];
    sumPrice = json['sumPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['oldQty'] = this.oldQty;
    data['oldUnitPrice'] = this.oldUnitPrice;
    data['unitPrice'] = this.unitPrice;
    data['finalPrice'] = this.finalPrice;
    data['sumPrice'] = this.sumPrice;
    return data;
  }
}

class Shippings {
  String? shipperName;
  String? shipperHtmlData;
  String? driverName;
  String? driverHtmlData;
  String? car;
  String? carIdentity;
  String? driverPhone;
  String? shipperPhone;
  int? orderId;
  int? totalItems;
  int? shippingCost;
  int? increasedCost;
  String? increasedCostDescription;
  String? blNo;
  String? departureTime;
  String? deliveredTime;
  String? originCity;
  String? originProvince;
  String? originAddress;
  String? targetCity;
  String? targetProvince;
  String? targetAddress;
  String? documentAttach;
  bool? inTownShipping;
  int? id;

  Shippings(
      {this.shipperName,
      this.shipperHtmlData,
      this.driverName,
      this.driverHtmlData,
      this.car,
      this.carIdentity,
      this.driverPhone,
      this.shipperPhone,
      this.orderId,
      this.totalItems,
      this.shippingCost,
      this.increasedCost,
      this.increasedCostDescription,
      this.blNo,
      this.departureTime,
      this.deliveredTime,
      this.originCity,
      this.originProvince,
      this.originAddress,
      this.targetCity,
      this.targetProvince,
      this.targetAddress,
      this.documentAttach,
      this.inTownShipping,
      this.id});

  Shippings.fromJson(Map<String, dynamic> json) {
    shipperName = json['shipperName'];
    shipperHtmlData = json['shipperHtmlData'];
    driverName = json['driverName'];
    driverHtmlData = json['driverHtmlData'];
    car = json['car'];
    carIdentity = json['carIdentity'];
    driverPhone = json['driverPhone'];
    shipperPhone = json['shipperPhone'];
    orderId = json['orderId'];
    totalItems = json['totalItems'];
    shippingCost = json['shippingCost'];
    increasedCost = json['increasedCost'];
    increasedCostDescription = json['increasedCostDescription'];
    blNo = json['blNo'];
    departureTime = json['departureTime'];
    deliveredTime = json['deliveredTime'];
    originCity = json['originCity'];
    originProvince = json['originProvince'];
    originAddress = json['originAddress'];
    targetCity = json['targetCity'];
    targetProvince = json['targetProvince'];
    targetAddress = json['targetAddress'];
    documentAttach = json['documentAttach'];
    inTownShipping = json['inTownShipping'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperName'] = this.shipperName;
    data['shipperHtmlData'] = this.shipperHtmlData;
    data['driverName'] = this.driverName;
    data['driverHtmlData'] = this.driverHtmlData;
    data['car'] = this.car;
    data['carIdentity'] = this.carIdentity;
    data['driverPhone'] = this.driverPhone;
    data['shipperPhone'] = this.shipperPhone;
    data['orderId'] = this.orderId;
    data['totalItems'] = this.totalItems;
    data['shippingCost'] = this.shippingCost;
    data['increasedCost'] = this.increasedCost;
    data['increasedCostDescription'] = this.increasedCostDescription;
    data['blNo'] = this.blNo;
    data['departureTime'] = this.departureTime;
    data['deliveredTime'] = this.deliveredTime;
    data['originCity'] = this.originCity;
    data['originProvince'] = this.originProvince;
    data['originAddress'] = this.originAddress;
    data['targetCity'] = this.targetCity;
    data['targetProvince'] = this.targetProvince;
    data['targetAddress'] = this.targetAddress;
    data['documentAttach'] = this.documentAttach;
    data['inTownShipping'] = this.inTownShipping;
    data['id'] = this.id;
    return data;
  }
}
