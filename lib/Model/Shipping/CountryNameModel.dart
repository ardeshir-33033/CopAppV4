

import 'ProvinceModel.dart';

class CountryName {
  String? name;
  String? persianName;
  String? flagIcon;
  String? globalCode;
  String? location;
  List<ProvinceModel>? countryProvinces;
  int? id;
  String? createDm;
  String? createDs;
  String? lastUpdateDm;
  String? lastUpdateDs;

  CountryName(
      {this.name,
        this.persianName,
        this.flagIcon,
        this.globalCode,
        this.location,
        this.countryProvinces,
        this.id,
        this.createDm,
        this.createDs,
        this.lastUpdateDm,
        this.lastUpdateDs});

  CountryName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    persianName = json['persianName'];
    flagIcon = json['flagIcon'];
    globalCode = json['globalCode'];
    location = json['location'];
    countryProvinces = json['countryProvinces'] != null ? ProvinceModel().listFromJson(json['countryProvinces']):null;

    id = json['id'];
    createDm = json['createDm'];
    createDs = json['createDs'];
    lastUpdateDm = json['lastUpdateDm'];
    lastUpdateDs = json['lastUpdateDs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['persianName'] = this.persianName;
    data['flagIcon'] = this.flagIcon;
    data['globalCode'] = this.globalCode;
    data['location'] = this.location;
    data['countryProvinces'] = this.countryProvinces;
    data['id'] = this.id;
    data['createDm'] = this.createDm;
    data['createDs'] = this.createDs;
    data['lastUpdateDm'] = this.lastUpdateDm;
    data['lastUpdateDs'] = this.lastUpdateDs;
    return data;
  }
    List<CountryName> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<CountryName>((ct) {
        return CountryName.fromJson(ct);
      }).toList();
    }
    return [];
  }
}