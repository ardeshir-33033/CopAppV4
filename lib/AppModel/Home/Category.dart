class Category {
  String? name;
  String? appName;
  int? id;

  Category({this.name, this.appName, this.id});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    appName = json['appName'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['appName'] = this.appName;
    data['id'] = this.id;
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
