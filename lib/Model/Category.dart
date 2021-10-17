class RCategory {
  String? name;
  int? id;
  int? sort;

  RCategory({
    this.id,
    this.sort,
    this.name,
  });

  RCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['sort'] = this.sort;
    return data;
  }

  List<RCategory>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<RCategory>((ct) {
        return RCategory.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
