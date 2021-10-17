class Shipping {
  String? shipperName;
  String? shipperHtmlData;
  String? driverName;
  String? driverHtmlData;
  String? car;
  // String carIdentity;
  String? driverPhone;
  String? shipperPhone;
  int? orderId;
  int? totalItems;
  double? shippingCost;
  double? increasedCost;
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
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  Shipping({
    this.shipperName,
    this.shipperHtmlData,
    this.driverName,
    this.driverHtmlData,
    this.car,
    // this.carIdentity,
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
    this.id,
    this.createDm,
    this.createDs,
    this.lastUpdateDm,
    this.lastUpdateDs,
  });

  Shipping.fromJson(Map<String, dynamic> json) {
    shipperName = json['shipperName'] ?? "";
    shipperHtmlData = json['shipperHtmlData'] ?? "";
    driverName = json['driverName'] ?? "";
    driverHtmlData = json['driverHtmlData'] ?? "";
    car = json['car'] ?? "";
    // carIdentity = json['carIdentity'] ?? 0;
    driverPhone = json['driverPhone'] ?? "";
    shipperPhone = json['shipperPhone'] ?? "";
    orderId = json['orderId'] ?? 0;
    totalItems = json['totalItems'] ?? 0;
    shippingCost = json['shippingCost'] ?? 0;
    increasedCost = json['increasedCost'] ?? 0;
    increasedCostDescription = json['increasedCostDescription'] ?? "";
    blNo = json['blNo'] ?? "";
    departureTime = json['departureTime'];
    deliveredTime = json['deliveredTime'];
    originCity = json['originCity'] ?? "";
    originProvince = json['originProvince'] ?? "";
    originAddress = json['originAddress'] ?? "";
    targetCity = json['targetCity'] ?? "";
    targetProvince = json['targetProvince'] ?? "";
    targetAddress = json['targetAddress'] ?? "";
    documentAttach = json['documentAttach'] ?? "";
    inTownShipping = json['inTownShipping'] ?? false;
    id = json['id'] ?? 0;
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperName'] = this.shipperName;
    data['shipperHtmlData'] = this.shipperHtmlData;
    data['driverName'] = this.driverName;
    data['driverHtmlData'] = this.driverHtmlData;
    data['car'] = this.car;
    // data['carIdentity'] = this.carIdentity;
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
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<Shipping> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Shipping>((ct) {
        return Shipping.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
