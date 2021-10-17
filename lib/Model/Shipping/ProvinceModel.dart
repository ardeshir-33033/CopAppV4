import 'ProvinceCityModel.dart';

class ProvinceModel {
  String? name;
  String? persianName;
  int? countryNameId;
  String ?location;
  List<ProvinceCities>? provinceCities;
  int ?id;

  ProvinceModel(
      {this.name,
      this.persianName,
      this.countryNameId,
      this.location,
      this.provinceCities,
      this.id});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    persianName = json['persianName'];
    countryNameId = json['countryNameId'];
    location = json['location'];
    if (json['provinceCities'] != null) {
     provinceCities =[];
      json['provinceCities'].forEach((v) {
        provinceCities!.add(new ProvinceCities.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['persianName'] = this.persianName;
    data['countryNameId'] = this.countryNameId;
    data['location'] = this.location;
    if (this.provinceCities != null) {
      data['provinceCities'] =
          this.provinceCities!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    return data;
  }
  List<ProvinceModel> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ProvinceModel>((ct) {
        return ProvinceModel.fromJson(ct);
      }).toList();
    }

    return [];
  }
}

