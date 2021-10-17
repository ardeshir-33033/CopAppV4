

import 'Car.dart';
import 'Category.dart';

class HomeModel {
  List<Category>? categories;
  List<Car>? cars;

  HomeModel({
    this.categories,
    this.cars,
  });

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(new Category.fromJson(v));
      });
    }
    if (json['keywords'] != null) {
      cars = [];
      json['keywords'].forEach((v) {
        cars!.add(new Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.cars != null) {
      data['keywords'] = this.cars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
