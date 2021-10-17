import '../Product.dart';

class OrdersFilterModel {
  List<String>? customers;
  List<Product>? products;
  double? minPrice;
  double? maxPrice;
  List<Statuses>? statuses;

  OrdersFilterModel(
      {this.customers,
        this.products,
        this.minPrice,
        this.maxPrice,
        this.statuses});

  OrdersFilterModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = json['customers'].cast<String>();
    }
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(new Product.fromJson(v));
      });
    }
    minPrice = json['minPrice'];
    maxPrice = json['maxPrice'];
    if (json['statuses'] != null) {
      statuses = [];
      json['statuses'].forEach((v) {
        statuses!.add(new Statuses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customers'] = this.customers;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['minPrice'] = this.minPrice;
    data['maxPrice'] = this.maxPrice;
    if (this.statuses != null) {
      data['statuses'] = this.statuses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Statuses {
  String? description;
  String? id;

  Statuses({this.description, this.id});

  Statuses.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['id'] = this.id;
    return data;
  }
}
