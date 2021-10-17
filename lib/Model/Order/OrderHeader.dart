

import 'package:copapp/Model/Shipping/Shipping.dart';

import 'Buyer.dart';
import 'OrderDetail.dart';
import 'OrderStatus.dart';
import 'PackingVideo.dart';

class OrderHeader {
  String? title;
  String? description;
  String? paymentDocAuthority;
  Buyer? buyer;
  String? code;
  int? buyerId;
  double? sumPrice;
  double? decreasedPrice;
  double? increasedPrice;
  double?finalPrice;
  String? saleInvoiceCode;
  int? saleInvoiceReferenceId;
  int? inventoryInvoiceReferenceId;
  int? reciptInvoiceReferenceId;
  String? orderStatusId;
  OrderStatus? orderStatus;
  List<OrderDetail>? orderDetails;
  List<PackingVideo>? packingVideos;
  List<Shipping>? shippings;
  String? paymentDocReferenceId;
  int? paymentDocFee;
  String? paymentDocFeeType;
  String? deliveryProvince;
  String? deliveryCity;
  String? deliveryAddress;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;
  double? commissionPrice;
  String? paidTime;
  String? paidRefId;
  String? paidRecipt;

  OrderHeader({
    this.title,
    this.description,
    this.code,
    this.buyer,
    this.buyerId,
    this.sumPrice,
    this.decreasedPrice,
    this.increasedPrice,
    this.finalPrice,
    this.saleInvoiceCode,
    this.saleInvoiceReferenceId,
    this.inventoryInvoiceReferenceId,
    this.reciptInvoiceReferenceId,
    this.orderStatusId,
    this.orderStatus,
    this.orderDetails,
    this.packingVideos,
    this.shippings,
    this.paymentDocAuthority,
    this.paymentDocReferenceId,
    this.paymentDocFee,
    this.paymentDocFeeType,
    this.deliveryProvince,
    this.deliveryCity,
    this.deliveryAddress,
    this.id,
    this.createDm,
    this.createDs,
    this.lastUpdateDm,
    this.lastUpdateDs,
    this.commissionPrice,
    this.paidRecipt,
    this.paidRefId,
    this.paidTime,
  });

  OrderHeader.fromJson(Map<String, dynamic> json) {
    title = json['title'] ?? "";
    description = json['description'] ?? "";
    commissionPrice = json['commissionPrice'] ?? 0.0;
    paidRecipt = json['paidRecipt'] ?? "";
    paidRefId = json['paidRefId'] ?? "";
    paidTime = json['paidTime'] ?? "";
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    code = json['code'] ?? "";
    buyerId = json['buyerId'] ?? 0;
    sumPrice = json['sumPrice'] ?? 0.0;
    decreasedPrice = json['decreasedPrice'] ?? 0.0;
    increasedPrice = json['increasedPrice'] ?? 0.0;
    finalPrice = json['finalPrice'] ?? 0.0;
    saleInvoiceCode = json['saleInvoiceCode'] ?? "";
    saleInvoiceReferenceId = json['saleInvoiceReferenceId'] ?? 0;
    inventoryInvoiceReferenceId = json['inventoryInvoiceReferenceId'] ?? 0;
    reciptInvoiceReferenceId = json['reciptInvoiceReferenceId'] ?? 0;
    orderStatusId = json['orderStatusId'] ?? "";
    orderStatus = json['orderStatus'] != null
        ? new OrderStatus.fromJson(json['orderStatus'])
        : null;
    if (json['orderDetails'] != null) {
      orderDetails = [];
      json['orderDetails'].forEach((v) {
        orderDetails!.add(new OrderDetail.fromJson(v));
      });
    }
    if (json['packingVideos'] != null) {
      packingVideos = [];
      json['packingVideos'].forEach((v) {
        packingVideos!.add(new PackingVideo.fromJson(v));
      });
    }
    if (json['shippings'] != null) {
      shippings = [];
      json['shippings'].forEach((v) {
        shippings!.add(new Shipping.fromJson(v));
      });
    }
    paymentDocAuthority = json['paymentDocAuthority'] ?? "";
    paymentDocReferenceId = json['paymentDocReferenceId'] ?? "";
    paymentDocFee = json['paymentDocFee'] ?? 0;
    paymentDocFeeType = json['paymentDocFeeType'] ?? "";
    deliveryProvince = json['deliveryProvince'] ?? "";
    deliveryCity = json['deliveryCity'] ?? "";
    deliveryAddress = json['deliveryAddress'] ?? "";
    id = json['id'] ?? 0;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['commissionPrice'] = this.commissionPrice;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    data['code'] = this.code;
    data['buyerId'] = this.buyerId;
    data['sumPrice'] = this.sumPrice;
    data['decreasedPrice'] = this.decreasedPrice;
    data['increasedPrice'] = this.increasedPrice;
    data['finalPrice'] = this.finalPrice;
    data['saleInvoiceCode'] = this.saleInvoiceCode;
    data['saleInvoiceReferenceId'] = this.saleInvoiceReferenceId;
    data['inventoryInvoiceReferenceId'] = this.inventoryInvoiceReferenceId;
    data['reciptInvoiceReferenceId'] = this.reciptInvoiceReferenceId;
    // data['orderStatusId'] = this.orderStatusId;
    if (this.orderStatus != null) {
      data['orderStatus'] = this.orderStatus!.toJson();
    }
    if (this.orderDetails != null) {
      data['orderDetails'] = this.orderDetails!.map((v) => v.toJson()).toList();
    }
    if (this.packingVideos != null) {
      data['packingVideos'] =
          this.packingVideos!.map((v) => v.toJson()).toList();
    }
    if (this.shippings != null) {
      data['shippings'] = this.shippings!.map((v) => v.toJson()).toList();
    }
    data['paymentDocAuthority'] = this.paymentDocAuthority;
    data['paymentDocReferenceId'] = this.paymentDocReferenceId;
    data['paymentDocFee'] = this.paymentDocFee;
    data['paymentDocFeeType'] = this.paymentDocFeeType;
    data['deliveryProvince'] = this.deliveryProvince;
    data['deliveryCity'] = this.deliveryCity;
    data['deliveryAddress'] = this.deliveryAddress;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
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
