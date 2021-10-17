class RSubCategory {
  String? name;
  int? id;

  RSubCategory({
    this.id,
    this.name,
  });

  RSubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }

  List<RSubCategory>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<RSubCategory>((ct) {
        return RSubCategory.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
