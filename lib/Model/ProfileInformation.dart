import 'FavoriteProduct.dart';

import 'Order/OrderHeader.dart';
import 'PersonalInformation.dart';

class ProfileInformation {
  PersonalInformation? personalInformation;
  List<FavoriteProduct>? favoriteProducts;
  List<OrderHeader>? userOrders;

  ProfileInformation({
    this.personalInformation,
    this.favoriteProducts,
    this.userOrders,
  });

  ProfileInformation.fromJson(Map<String, dynamic> json) {
    personalInformation = json['personalInformation'] != null
        ? new PersonalInformation.fromJson(json['personalInformation'])
        : null;
    if (json['favoriteProducts'] != null) {
     List<FavoriteProduct> favoriteProducts = [];
      json['favoriteProducts'].forEach((v) {
        favoriteProducts.add(new FavoriteProduct.fromJson(v));
      });
    }
    if (json['userOrders'] != null) {
      List<OrderHeader> userOrders = [];
      json['userOrders'].forEach((v) {
        userOrders.add(new OrderHeader.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.personalInformation != null) {
      data['personalInformation'] = this.personalInformation!.toJson();
    }
    if (this.favoriteProducts != null) {
      data['favoriteProducts'] =
          this.favoriteProducts!.map((v) => v.toJson()).toList();
    }
    if (this.userOrders != null) {
      data['userOrders'] = this.userOrders!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<ProfileInformation> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ProfileInformation>((ct) {
        return ProfileInformation.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
