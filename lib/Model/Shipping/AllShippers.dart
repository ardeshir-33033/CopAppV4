

import 'ShipperDestinationModel.dart';

class AllShippers {
  String? shipperName;

  // String shipperHtmlData;
  double? shippingBaseCost;
  double? taxCost;
  String? openingTime;
  String? closingTime;
  String? logo;
  bool? urban;
  bool? suburban;
  bool? terminal;
  List<ShipperDestination>? shipperDistinations;
  int? id;
  String? createDm;
  String? terminalName;

  // String createDs;
  // String lastUpdateDm;
  // String lastUpdateDs;

  AllShippers(
      {this.shipperName,
      // this.shipperHtmlData,
      this.shippingBaseCost,
      this.taxCost,
      this.openingTime,
      this.closingTime,
      this.logo,
      this.urban,
      this.suburban,
      this.terminal,
      this.shipperDistinations,
      this.id,
      this.createDm,
      this.terminalName
      // this.createDs,
      // this.lastUpdateDm,
      // this.lastUpdateDs
      });

  AllShippers.fromJson(Map<String, dynamic> json) {
    shipperName = json['shipperName'];
    // shipperHtmlData = json['shipperHtmlData'];
    shippingBaseCost = json['shippingBaseCost'];
    taxCost = json['taxCost'];
    openingTime = json['openingTime'];
    closingTime = json['closingTime'];
    logo = json['logo'];
    urban = json['urban'];
    suburban = json['suburban'];
    terminal = json['terminal'];
    terminalName = json['terminalName'];

    if (json['shipperDistinations'] != null) {
      shipperDistinations = [];
      json['shipperDistinations'].forEach((v) {
        shipperDistinations!.add(ShipperDestination.fromJson(v));
      });
    }
    id = json['id'];
    createDm = json['createDm'];
    // createDs = json['createDs'];
    // lastUpdateDm = json['lastUpdateDm'];
    // lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperName'] = this.shipperName;
    // data['shipperHtmlData'] = this.shipperHtmlData;
    data['shippingBaseCost'] = this.shippingBaseCost;
    data['taxCost'] = this.taxCost;
    data['openingTime'] = this.openingTime;
    data['closingTime'] = this.closingTime;
    data['logo'] = this.logo;
    data['urban'] = this.urban;
    data['suburban'] = this.suburban;
    data['terminal'] = this.terminal;
    data['terminalName'] = this.terminalName;
    if (this.shipperDistinations != null) {
      data['shipperDistinations'] =
          this.shipperDistinations!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    // data['createDs'] = this.createDs;
    // data['lastUpdateDm'] = this.lastUpdateDm;
    // data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<AllShippers> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<AllShippers>((ct) {
        return AllShippers.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
