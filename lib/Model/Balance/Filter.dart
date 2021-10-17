class Filter {
  String? name;
  int? id;
  bool? selected;

  Filter({this.name, this.id, this.selected});

  Filter.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? 0;
    selected = json['selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['selected'] = this.selected;
    return data;
  }

  List<Filter>? listFromJson(dynamic jsns) {
    if (jsns != null) {
      return jsns.map<Filter>((ct) {
        return Filter.fromJson(ct);
      }).toList();
    }

    return null;
  }
}
