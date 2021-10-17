class Category {
  String? name;
  int? id;
  int? sort;

  Category({
    this.id,
    this.sort,
    this.name,
  });

  Category.fromJson(Map<String, dynamic> json) {
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

  List<Category>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Category>((ct) {
        return Category.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
