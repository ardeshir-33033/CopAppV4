import '../Category.dart';
import '../Keyword.dart';

class HomeModel {
  List<Category>? categories;
  List<Keyword>? keywords;

  HomeModel({
    this.categories,
    this.keywords,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
    if (json['keywords'] != null) {
      keywords = [];
      json['keywords'].forEach((v) {
        keywords!.add(new Keyword.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.keywords != null) {
      data['keywords'] = this.keywords!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
