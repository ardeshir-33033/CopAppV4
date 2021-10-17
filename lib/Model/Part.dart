import 'package:copapp/AppModel/Balance/Product.dart';
import 'Category.dart';
import 'Vehicle.dart';

class RPart {
  String? partNumber;
  String? appName;
  String? name;
  String? familyTitle;
  String? joinTitle;
  String? thumbImagePath;
  List<Product>? products;
  List<Vehicle>? vehicles;
  List<RCategory>? categories;
  List<RPart>? family;
  List<RPart>? join;
  int? id;
  String? imagePath;
  String? vehiclesPersianName;
  int? nameForSort;

  RPart({
    this.partNumber,
    this.appName,
    this.name,
    this.familyTitle,
    this.joinTitle,
    this.products,
    this.thumbImagePath,
    this.vehicles,
    this.family,
    this.join,
    this.categories,
    this.id,
    this.imagePath,
    this.vehiclesPersianName,
    this.nameForSort,
  });

  RPart.fromJson(Map<String, dynamic> json) {
    partNumber = json['partNumber'] ?? "";
    name = json['name'] ?? "";
    appName = json['appName'] ?? "";
    familyTitle = json['familyTitle'] ?? "";
    joinTitle = json['joinTitle'] ?? "";
    thumbImagePath = json['thumbImagePath'] ?? "";
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['families'] != null) {
      family = [];
      json['families'].forEach((v) {
        family!.add(RPart.fromJson(v));
      });
    }
    if (json['joines'] != null) {
      join = [];
      json['joines'].forEach((v) {
        join!.add(RPart.fromJson(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicle.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(new RCategory.fromJson(v));
      });
    }
    id = json['id'] ?? 0;
    imagePath = json['imagePath'] ?? "";
    vehiclesPersianName = json['vehiclesPersianName'] ?? "";
    nameForSort = json['nameForSort'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partNumber'] = this.partNumber;
    data['name'] = this.name;
    data['familyTitle'] = this.familyTitle;
    data['thumbImagePath'] = this.thumbImagePath;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['families'] = this.family!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['joines'] = this.join!.map((v) => v.toJson()).toList();
    }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['vehiclesPersianName'] = this.vehiclesPersianName;
    data['nameForSort'] = this.nameForSort;
    return data;
  }

  List<RPart>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<RPart>((ct) {
        return RPart.fromJson(ct);
      }).toList();
    }

    return null;
  }

  // void displayImageSlider(BuildContext context) {
  //   if (this.products != null && this.products!.length > 0) {
  //     this.products!.first.displayImageSlider(context);
  //   }
  // }
}
