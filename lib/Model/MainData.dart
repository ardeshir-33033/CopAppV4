

import 'FavoriteProduct.dart';
import 'Order/OrderHeader.dart';

import 'PersonalInformation.dart';

class MainData {
  PersonalInformation? personalInformation;
  List<FavoriteProduct>? favoriteProducts;
  List<OrderHeader>? userOrders;

  MainData({this.personalInformation, this.favoriteProducts, this.userOrders});

  MainData.fromJson(Map<String, dynamic> json) {
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
        userOrders.add(OrderHeader.fromJson(v));
      });
    }
  }

  List<MainData> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<MainData>((ct) {
        return MainData.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
