class Brand {
  String? name;
  String? imagePath;
  int? id;

  Brand({
    this.name,
    this.imagePath,
    this.id,
  });

  Brand.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    imagePath = json['imagePath'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    data['id'] = this.id;
    return data;
  }

  List<Brand>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Brand>((ct) {
        return Brand.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
