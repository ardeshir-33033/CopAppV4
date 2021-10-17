import 'package:copapp/AppModel/MultiBalance/SubCategory.dart';
import 'package:copapp/Model/Balance/Filter.dart';

class FilterBox {
  List<SubCategory>? subCategories;
  List<Filter>? filters;

  FilterBox({this.subCategories, this.filters});

  FilterBox.fromJson(Map<String, dynamic> json) {
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        subCategories!.add(new SubCategory.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters!.add(new Filter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}