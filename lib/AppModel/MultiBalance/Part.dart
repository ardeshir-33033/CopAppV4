import 'package:copapp/AppModel/Balance/Product.dart';
import 'package:copapp/Model/Vehicle.dart';

class Part {
  String? partNumber;
  String? appName;
  String? name;
  String? familyTitle;
  // String? joinTitle;
  String? thumbImagePath;
  String? partImage;
  List<Product>? products;
  List<Vehicle>? vehicles;
  // List<Category>? categories;
  List<Part>? family;
  // List<Part>? join;
  int? id;
  String? vehiclePersianName;
  String? vehicleEnglishName;

  Part({
    this.partNumber,
    this.appName,
    this.name,
    this.familyTitle,
    // this.joinTitle,
    this.products,
    this.thumbImagePath,
    this.vehicles,
    this.family,
    this.partImage,
    // this.join,
    // this.categories,
    this.id,
    this.vehiclePersianName,
    this.vehicleEnglishName,
  });

  Part.fromJson(Map<String, dynamic> json) {
    partNumber = json['partNumber'] ?? "";
    name = json['name'] ?? "";
    appName = json['appName'] ?? "";
    familyTitle = json['familyTitle'] ?? "";
    // joinTitle = json['joinTitle'] ?? "";
    partImage = json['partImage'] ?? "";
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
        family!.add(Part.fromJson(v));
      });
    }
    // if (json['joines'] != null) {
    // join = [];
    // json['joines'].forEach((v) {
    //   join!.add(Part.fromJson(v));
    // });
    // }
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicle.fromJson(v));
      });
    }
    // if (json['categories'] != null) {
    //   categories = [];
    //   json['categories'].forEach((v) {
    //     categories!.add(new Category.fromJson(v));
    //   });
    // }
    id = json['id'] ?? 0;
    vehiclePersianName = json['vehiclePersianName'] ?? "";
    vehicleEnglishName = json['vehicleEnglishName'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partNumber'] = this.partNumber;
    data['name'] = this.name;
    data['familyTitle'] = this.familyTitle;
    data['thumbImagePath'] = this.thumbImagePath;
    data['partImage'] = this.partImage;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.family != null) {
      data['families'] = this.family!.map((v) => v.toJson()).toList();
    }
    // if (this.join != null) {
    //   data['joines'] = this.join!.map((v) => v.toJson()).toList();
    // }
    if (this.vehicles != null) {
      data['vehicles'] = this.vehicles!.map((v) => v.toJson()).toList();
    }
    // if (this.categories != null) {
    //   data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    // }
    data['id'] = this.id;
    data['vehiclePersianName'] = this.vehiclePersianName;
    data['vehicleEnglishName'] = this.vehicleEnglishName;
    return data;
  }

  List<Part>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Part>((ct) {
        return Part.fromJson(ct);
      }).toList();
    }

    return null;
  }

  listFromJsonOld(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Part>((ct) {
        return Part.fromJsonOld(ct);
      }).toList();
    }

    return null;
  }

  Part.fromJsonOld(Map<String, dynamic> json) {
      partNumber = json['partNumber'] ?? "";
    name = json['name'] ?? "";
    appName = json['appName'] ?? "";
    familyTitle = json['familyTitle'] ?? "";
    thumbImagePath = json['thumbImagePath'] ?? "";
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJsonOld(v));
      });
    }
    if (json['vehicles'] != null) {
      vehicles = [];
      json['vehicles'].forEach((v) {
        vehicles!.add(new Vehicle.fromJson(v));
      });
    }
    id = json['id'] ?? 0;
    partImage = json['imagePath'] ?? "";
    vehiclePersianName = json['vehiclesPersianName'] ?? "";
  }

// void displayImageSlider(BuildContext context) {
//   if (this.products != null && this.products!.length > 0) {
//     this.products!.first.displayImageSlider(context);
//   }
// }
}
