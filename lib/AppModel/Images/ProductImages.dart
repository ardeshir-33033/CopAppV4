class ProductImage {
  String? path;
  String? type;
  int? id;


  ProductImage({this.path, this.type , this.id});

  ProductImage.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    data['id'] = this.id;
    return data;
  }
}