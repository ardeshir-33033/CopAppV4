class SubCategory {
  String? name;
  String? appName;
  int? id;

  SubCategory({
    this.id,
    this.appName,
    this.name,
  });

  SubCategory.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
    appName = json['appName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['appName'] = this.appName;
    return data;
  }

  List<SubCategory>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<SubCategory>((ct) {
        return SubCategory.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
