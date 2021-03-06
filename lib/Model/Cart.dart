

import 'CartDetail.dart';
import 'ConflictsPrice.dart';
import 'ConflictsQty.dart';

class RCart {
  int? id;
  double? sumPrice;
  double? finalPrice;
  double? decreasePrice;
  List<RCartDetail>? cartDetails;
  List<ConflictsQty>? conflictsQty;
  List<ConflictsPrice>? conflictsPrice;

  RCart({
    this.sumPrice,
    this.finalPrice,
    this.id,
    this.decreasePrice,
    this.cartDetails,
    this.conflictsPrice,
    this.conflictsQty,
  });

  RCart.fromJson(dynamic jsn) {
    if (jsn == null) return;

    // this.id = jsn["id"] != null ? int.parse(jsn["id"].toString()) : 0;
    this.id = jsn['id'] != null ? jsn['id'] : 0;
    this.sumPrice = jsn["sumPrice"] != null
        ? jsn["sumPrice"]
        : 0.0;
    this.cartDetails = jsn["cartDetails"] != null
        ? RCartDetail().listFromJson(jsn["cartDetails"])
        : null;
    this.finalPrice = jsn["finalPrice"] != null
        ? jsn["finalPrice"]
        : 0.0;
    this.decreasePrice = jsn["decreasePrice"] != null
        ? jsn["decreasePrice"]
        : 0;
    this.conflictsQty = jsn["conflictsQty"] != null
        ? ConflictsQty().listFromJson(jsn["conflictsQty"])
        : null;
    this.conflictsPrice = jsn["conflictsPrice"] != null
        ? ConflictsPrice().listFromJson(jsn["conflictsPrice"])
        : null;
  }

  List<RCart>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<RCart>((ct) {
        return RCart.fromJson(ct);
      }).toList();
    }

    return null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finalPrice'] = this.finalPrice;
    if (this.cartDetails != null) {
      data['cartDetails'] = this.cartDetails!.map((v) => v.toJson()).toList();
    }
    if (this.conflictsQty != null) {
      data['conflictsQty'] = this.cartDetails!.map((v) => v.toJson()).toList();
    }
    if (this.conflictsPrice != null) {
      data['conflictsPrice'] = this.cartDetails!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data["decreasePrice"] = this.decreasePrice;
    data["sumPrice"] = this.sumPrice;

    return data;
  }
}
