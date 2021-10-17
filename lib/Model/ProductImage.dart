class ProductImage {
  String? path;
  String? type;
  int? id;

  ProductImage({
    this.path,
    this.type,
    this.id,
  });

  ProductImage.fromJson(Map<String, dynamic> json) {
    path = json['path'] ?? "";
    type = json['type'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }

  List<ProductImage>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<ProductImage>((ct) {
        return ProductImage.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
