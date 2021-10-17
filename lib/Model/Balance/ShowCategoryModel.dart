

import '../Category.dart';
import '../Keyword.dart';
import '../Part.dart';
import '../Vehicle.dart';
import 'Filter.dart';
import 'SubCategory.dart';

class ShowCategoryModel {
  List<Keyword>? keywords;
  List<Vehicle>? vehicles;
  Category? category;
  List<SubCategory>? subCategories;
  List<Filter>? filters;
  List<Part>? parts;
  int? totalParts;

  ShowCategoryModel({
    this.keywords,
    this.vehicles,
    this.category,
    this.subCategories,
    this.filters,
    this.parts,
    this.totalParts,
  });

  ShowCategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['keywords'] != null) {
      keywords = [];
      json['keywords'].forEach((v) {
        keywords!.add(Keyword.fromJson(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles!.add(Vehicle.fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['subCategories'] != null) {
      subCategories = [];
      json['subCategories'].forEach((v) {
        if (v != null) subCategories!.add(SubCategory.fromJson(v));
      });
    }
    if (json['filters'] != null) {
      filters = [];
      json['filters'].forEach((v) {
        filters!.add(new Filter.fromJson(v));
      });
    }

    try {
      if (json['parts'] != null) {
        parts = [];
        json['parts'].forEach((v) {
          parts!.add(Part.fromJson(v));
        });
      }
    } catch (e) {
      parts = null;
    }
    totalParts = json['totalParts'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.keywords != null) {
      data['keywords'] = this.keywords!.map((v) => v.toJson()).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.subCategories != null) {
      data['subCategories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    if (this.filters != null) {
      data['filters'] = this.filters!.map((v) => v.toJson()).toList();
    }
    if (this.parts != null) {
      data['parts'] = this.parts!.map((v) => v.toJson()).toList();
    }
    data['totalParts'] = this.totalParts;
    return data;
  }
}
