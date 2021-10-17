

import 'Destination.dart';

class ShipperDestination {
  int? shipperDataId;
  int? originId;
  String? originSummary;
  int? distinationId;
  String? distinationSummary;
  Destinations? distination;
  double? perG;
  double? perKG;
  double? perCBM;
  double? perBox;
  String? durationSummary;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  ShipperDestination(
      {this.shipperDataId,
      this.originId,
      this.originSummary,
      this.distinationId,
      this.distinationSummary,
      this.distination,
      this.perG,
      this.perKG,
      this.perCBM,
      this.perBox,
      this.durationSummary,
      this.id,
      this.createDm,
      this.createDs,
      this.lastUpdateDm,
      this.lastUpdateDs});

  ShipperDestination.fromJson(Map<String, dynamic> json) {
    shipperDataId = json['shipperDataId'];
    originId = json['originId'];
    originSummary = json['originSummary'];
    distinationId = json['distinationId'];
    distinationSummary = json['distinationSummary'];
    // distination = Destinations.fromJson(json['distination']);
    distination =
    json['distination'] != null ? new Destinations.fromJson(json['distination']) : null;
    perG = json['perG'];
    perKG = json['perKG'];
    perCBM = json['perCBM'];
    perBox = json['perBox'];
    durationSummary = json['durationSummary'];
    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipperDataId'] = this.shipperDataId;
    data['originId'] = this.originId;
    data['originSummary'] = this.originSummary;
    data['distinationId'] = this.distinationId;
    data['distinationSummary'] = this.distinationSummary;
    data['distination'] = this.distination;
    data['perG'] = this.perG;
    data['perKG'] = this.perKG;
    data['perCBM'] = this.perCBM;
    data['perBox'] = this.perBox;
    data['durationSummary'] = this.durationSummary;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }

  List<ShipperDestination> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ShipperDestination>((ct) {
        return ShipperDestination.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
