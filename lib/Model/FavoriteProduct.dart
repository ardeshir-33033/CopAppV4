class FavoriteProduct {
  int? productId;
  String? partName;
  String ?brand;
  String? partNumber;
  int? price;
  String? imageAddress;

  FavoriteProduct(
      {this.productId,
      this.partName,
      this.brand,
      this.partNumber,
      this.price,
      this.imageAddress});

  FavoriteProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] ?? 0;
    partName = json['partName'] ?? "";
    brand = json['brand'] ?? "";
    partNumber = json['partNumber'] ?? "";
    price = json['price'] ?? 0.0;
    imageAddress = json['imageAddress'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['partName'] = this.partName;
    data['brand'] = this.brand;
    data['partNumber'] = this.partNumber;
    data['price'] = this.price;
    data['imageAddress'] = this.imageAddress;
    return data;
  }

  List<FavoriteProduct> listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<FavoriteProduct>((ct) {
        return FavoriteProduct.fromJson(ct);
      }).toList();
    }

    return [];
  }
}
