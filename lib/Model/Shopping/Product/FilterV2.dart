import '../../Brand.dart';
import 'FilterType.dart';

class FilterV2 {
  FilterType? type;
  FilterType? tip;
  FilterType? model;
  Brand? brand;
  FilterType? year;
  String? name;
  String? imagePath;
  String? persianName;
  int? id;

  FilterV2({
    this.type,
    this.tip,
    this.model,
    this.brand,
    this.year,
    this.name,
    this.imagePath,
    this.persianName,
    this.id,
  });

  FilterV2.fromJson(Map<String, dynamic> json) {
    type = json['type'] != null ? new FilterType.fromJson(json['type']) : null;
    tip = json['tip'] != null ? new FilterType.fromJson(json['tip']) : null;
    model =
    json['model'] != null ? new FilterType.fromJson(json['model']) : null;
    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    year = json['year'] != null ? new FilterType.fromJson(json['year']) : null;
    name = json['name'] ?? "";
    imagePath = json['imagePath'] ?? "";
    persianName = json['persianName'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.tip != null) {
      data['tip'] = this.tip!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    if (this.brand != null) {
      data['brand'] = this.brand!.toJson();
    }
    if (this.year != null) {
      data['year'] = this.year!.toJson();
    }
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    data['persianName'] = this.persianName;
    data['id'] = this.id;
    return data;
  }

  List<FilterV2>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<FilterV2>((ct) {
        return FilterV2.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
